#!/usr/bin/env ruby

require 'rubygems'
require 'require_all'
require 'sinatra'
# require 'sinatra/cookies'
require 'rest_client'
require 'json'
require 'open-uri'
require 'active_support/all'

if development?
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
    def h(text)
      Rack::Utils.escape_html(text)
    end

    def me
      session[:current_user]
    end

    def opponent
      me.world.p1 == me ?  me.world.p2 :  me.world.p1
    end

  end

  def initialize
    super
    @players = []
  end

  get "/" do
    erb :home
  end

  get "/game" do
    redirect "/clear" if me == nil || me.world == nil || !me.world.ready?
    @world = me.world
    erb :game , layout: !request.xhr?
  end

  get "/next" do
    me.world.turn.next! if me.active?
    while(me.world.active_player.ai == true) do
      me.world.active_player.auto_play!
    end
    notify!
    redirect "/game"
  end

  get "/clear_all" do
    @players = []
    redirect "/clear"
  end

  get "/clear" do
    me.world = nil if me && me.world
    @players.delete me
    session.clear
    notify!
    redirect "/"
  end

  get "/login" do
    session[:current_user] =  Player.new
    me.name = params[:name]
    @players << me
    notify!
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
    # 1.times {  world.p1.permanents <<  WinterWall.new(me) }
    # 1.times {  world.p1.permanents <<  Gob.new(me) }
    # 1.times {  world.p2.permanents <<  Nightmare.new(world.p2)  }
    # 1.times {  world.p2.permanents <<  Elf.new(world.p2)  }
    redirect "/game"
  end

  get "/action/:action_id/?:target_id?" do
    action  = Action.find(params[:action_id])
    if !params[:target_id]
      action.execute!
    else
      action.execute_with_target! Card.find(params[:target_id])
    end
    notify!
    redirect "/game"
  end

  get "/attack_all" do
    me.attack_all!
    notify!
    redirect "/game"
  end

  get "/cancel_target" do
    me.world.target_action = nil
    notify!
    redirect "/game"
  end

  get '/auto' do
    me.auto_play! if me.active?
    notify!
    redirect "/game"
  end



  get '/cards' do
    me.world = World.new(Player.new,Player.new )
    @cards=[]
    Creature.all.each do |card_class|
        card = card_class.new me.world.p1
        @cards << card
    end
    @cards = @cards.sort_by(&:cost)
    erb :cards
  end





  @@connections = []
  @@notifications = []

  def notify!(msg={})
    notification = msg.to_json

    @@notifications << notification

    # @@notifications.shift if @@notifications.length > 10
    @@connections.each { |out| out << "data: #{notification}\n\n"}
  end


  get '/comet', provides: 'text/event-stream' do
    stream :keep_open do |out|
      @@connections << out

      #out.callback on stream close evt.
      out.callback {
        #delete the connection
        @@connections.delete(out)
      }
    end
  end




  get '/card_importer' do
    params[:name] ||= "zombie"
    params[:img_query] ||= params[:name]
    response = RestClient.get "http://api.mtgdb.info/search/#{URI::encode(params[:name])}?start=0&limit=0"
    @cards = JSON.parse(response)
    @cards = @cards.uniq{ |c| c['name'] }.sort_by{ |c| c['name'] }
    @card = @cards.find{ |c| c['id'] == params[:id].to_i}
    res = RestClient::Resource.new( "https://api.datamarket.azure.com/Bing/Search/v1/Image?Query=%27#{URI::encode(params[:img_query])}%27&$format=json&ImageFilters=%27Size%3AMedium%27", '', '7IU5fLJU28Y49NTV0zTLIuEQm+lS5So82uWaqpUIOF8' )
    @images= JSON.parse(res.get)
    erb :card_importer , layout: false
  end

end
