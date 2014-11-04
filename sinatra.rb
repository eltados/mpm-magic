#!/usr/bin/env ruby

require 'rubygems'
require 'require_all'
require 'sinatra'
require 'rest_client'
require 'json'
require 'open-uri'
require 'active_support/all'
require 'newrelic_rpm' if !development?
require 'date'



if development?
  $ENV = ENV
  require 'chunky_png'
  require "better_errors"
  require 'sinatra/reloader'
end

require_all 'lib'


class App <  Sinatra::Application

  configure do
    set :bind, '0.0.0.0'
    use Rack::Session::Pool
    set :session_secret, 'secret'
    set :views, Proc.new { File.join(root, "views") }
  end

  configure :development do
    use BetterErrors::Middleware
    BetterErrors.application_root = __dir__
  end

  helpers do

    def dev?
      $ENV && $ENV['RACK_ENV'] == "development"
    end

    def h(text)
      Rack::Utils.escape_html(text)
    end

    def me
      session[:current_user]
    end

    def hp_color(hp)
       return "hp_5" if hp <= 5
       return "hp_10" if hp <= 10
       return "hp_15" if hp <= 15
      ""
    end


    def opponent
      me.world.p1 == me ?  me.world.p2 :  me.world.p1
    end

    def world
      me.world
    end


  end

  def dl_and_crop(id)
    img_url = "http://api.mtgdb.info/content/card_images/#{id}.jpeg"
    jpg_path="/tmp/#{id}_full.jpeg"
    if !File.exist?(jpg_path)
      file = open(img_url).read
      File.open(jpg_path, 'wb') do |file|
        file << open(img_url).read
      end
    end
    png_path="/tmp/#{id}_full.png"
    png_cropped_path="/tmp/#{id}.png"
    File.delete(png_path) if File.exist?(png_path)
    `mogrify -format png #{jpg_path}`
    image = ChunkyPNG::Image.from_file(png_path)
    File.delete(png_cropped_path) if File.exist?(png_cropped_path)
    image.crop!(27,40,169,128).save(png_cropped_path)
    File.delete(png_path) if File.exist?(png_path)
    File.delete(jpg_path) if File.exist?(jpg_path)
    File.rename( png_cropped_path, "#{ENV['PWD']}/public/cards/#{id}.png" )
    return true
  end

  def initialize
    super
    @players = []
  end

  get "/" do
    erb :home
  end


  get "/game.yaml" do
    content_type 'text/yaml'
    redirect "/clear" if me == nil || me.world == nil || !me.world.ready?
    yaml = me.world.to_yaml
    # YAML.load(yaml)
    yaml
  end

  get "/game" do
    redirect "/clear" if me == nil || me.world == nil || !me.world.ready?
    @world = me.world
    erb :game , layout: !request.xhr?
  end


  get "/clear_all" do
    @players = []
    redirect "/clear"
  end



  get "/clear" do
    me.world = nil if me && me.world
    @players.delete me
    session.clear
    # notify!
    redirect "/"
  end

  get "/login" do
    session[:current_user] =  Player.new
    me.name = params[:name]
    @players << me
    # notify!
    redirect "/"
  end


  get "/game/new" do
      world  = World.new(me)
      world.p1 = me
      world.p2 = nil
      me.world = world
      notify!
      redirect "/"
  end

  get "/game/load/:world" do
      game =  RestClient.get("http://hastebin.com/raw/#{params[:world]}" )
      world  = YAML.load(game)
      session[:current_user] = world.p1
      redirect "/game"
  end


  get "/game/save" do
    r = RestClient.post("http://hastebin.com/documents", me.world.to_yaml.to_s)
    key = JSON.parse(r)['key']
    "<h1><a href='http://#{request.host_with_port}/game/load/#{key}'>
        Load Game [#{JSON.parse(r)['key']}] : #{me.world.p1.name} (#{me.world.p1.health} HP) vs #{me.world.p2.name} (#{me.world.p2.health} HP) : turn #{me.world.turn.number}
        </a>
      </h1><br> <a href='http://hastebin.com/#{key}'>Edit</a>
            <br> <a href='http://#{request.host_with_port}/game'>Back to the Game</a> "
  end


  get "/game/cancel" do
    me.world = nil
    notify!
    redirect "/"
  end

  get "/game/join/:world_id" do
    me.world = World.find(params[:world_id])
    me.world.p2 = me
    me.world.start!
    notify!
    redirect "/game"
  end

  get "/game/ai" do
    world = World.new(me, nil)
    me.world =  world
    world.p1 = me

    world.p2 = Player.new(self)
    world.p2.name= "Robot"
    world.p2.ai= true
    world.p2.world = world
    world.start!

    redirect "/game"
  end

  get "/game/ai2" do

    session[:current_user] =  Player.new
    me.name = "Mathieu"
    @players << me

    redirect "/game/ai"
  end

  get "/next" do
    notify = SinApp.action( me, me.actions.first )

    notify! if notify
    ai!

    redirect "/game"
  end

  def ai!
    if world.p2.ai == true
      while world.p2.active?
         world.p2.auto_play!
      end
    end
  end

  get "/action/:action_id/?:target_id?" do
    action  = Action.find(params[:action_id])
    target = Card.find(params[:target_id]) if params[:target_id]

    notify = SinApp.action( me, action, target )

    notify! if notify
    ai!

    redirect "/game"

  end

  get "/resolve" do
    me.world.resolve_stack! if me.active?
    ai!
    notify!
    redirect "/game"
  end

  get "/attack_all" do
    me.attack_all!
    notify!
    redirect "/game"
  end

  get "/notify/?:player_id?" do
    player = Player.find(params[:player_id])
    puts "Tell #{player}"
    notify!(player)
  end

  get "/cancel_target_action" do
    me.target_action = nil
    notify!
    redirect "/game"
  end

  get '/auto' do
    me.auto_play! if me.active?
    ai!
    notify!
    redirect "/game"
  end



  get '/cards' do
    @cards= [Card.all].flatten.map(&:new).sort do |a, b|
     [a.is_a?(Land)? 0: 1, a.type, a.cost ] <=> [b.is_a?(Land)? 0: 1, b.type, b.cost]
    end

    erb :cards
  end


  get '/decks/base' do
      @cards= Deck.base.cards.map do |card_class|
          card_class.new
      end
      erb :cards
  end


  @@connections = {}
  @@notifications = []

  def notify!(player = nil)

    notification = '' # msg.to_json

    player = player == nil  ? opponent : player

    # @@notifications << notification
      puts "@@connections  = #{@@connections.object_id}"
    # @@notifications.shift if @@notifications.length > 10
    if  player != nil && player.world !=nil && @@connections[player.to_param] != nil
      # msg = player.world.logs[-1].to_json
      msg = ""
      # msg = '{"time":"2014-10-10T22:57:37.740+01:00","card":"18623600-mpm","action":"hit","target":"me"}'
      puts "notify #{player} : #{msg}"
      @@connections[player.to_param] << "data: #{msg}\n\n"
    else
      puts "no body to notify"
      if player!=nil &&  player.name == "Mathieu"
        puts "\n\n\n\n"
        puts "player = #{player.to_param}"
        puts "@@connections  = #{@@connections.object_id}"
        puts "@@connections[player.to_param]  = #{@@connections[player.to_param].nil?}"
        puts "@@connections.keys  = #{@@connections.keys.inspect}"
        puts "player.world  = #{player.world}"
      end
    end
  end


  get '/comet', provides: 'text/event-stream' do

    stream :keep_open do |out|
      @@connections[me.to_param] = out

      #out.callback on stream close evt.
      out.callback {
        #delete the connection
        @@connections.delete me.to_param
      }
    end
  end




  get '/env' do
    ENV.inspect
  end

  def create_card(id)
    json = JSON.parse(RestClient.get("http://api.mtgdb.info/cards/#{id}"))
    file = """
class #{json['name'].gsub(/ |'|-/,'').camelcase} < #{json['type']}

  def initialize(owner=nil)
    super(owner)
    @name = \"#{json['name']}\"
"""
    if json['type'] ==  'Creature'
    file +="""
    @strength = #{json['power']}
    @toughness = #{json['toughness']}"""
    end
    file +="""
    @cost = #{json['manaCost'].to_i + json['manaCost'].scan(/[^0-9]/m).size} # #{json['manaCost']}
    @description =  \"#{json['description'].gsub("\n",' ').gsub("\"",'\\"')}\"
    @img = \"cards/#{json['id']}.png\"
    @mtg_id = #{json['id']}
  end

  def self.disabled?; true end

end
    """
    File.open( "#{ENV['PWD']}/lib/cards/imported/#{json['name'].gsub(/ |'/,'').underscore}.rb", 'w') { |f| f.write(file) }
  end

  get '/import/:id' do
    dl_and_crop(params[:id])
    create_card(params[:id])
    "Imported !"
  end


  get '/card_importer' do
    params[:name] ||= "random"
    params[:img_query] ||= params[:name]
    if params[:name] == "random"
      responses = []
      8.times do
        responses << RestClient.get("http://api.mtgdb.info/cards/random")
      end
      response = "[#{responses.join(',')}]"
      # response = "[]"
    else
      response = RestClient.get "http://api.mtgdb.info/search/#{URI::encode(params[:name])}?start=0&limit=0"
    end
    @cards = JSON.parse(response)
    @cards = @cards.uniq{ |c| c['name'] }.sort_by{ |c| c['name'] }
    # @card = @cards.find{ |c| c['id'] == params[:id].to_i}
    # res = RestClient::Resource.new( "https://api.datamarket.azure.com/Bing/Search/v1/Image?Query=%27#{URI::encode(params[:img_query])}%27&$format=json&ImageFilters=%27Size%3AMedium%27", '', '7IU5fLJU28Y49NTV0zTLIuEQm+lS5So82uWaqpUIOF8' )
    # @images= JSON.parse(res.get)
    erb :card_importer , layout: false
  end

end
