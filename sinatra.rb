#!/usr/bin/env ruby

require 'rubygems'
require 'require_all'
require 'sinatra'
require 'rest_client'
require 'json'
require 'open-uri'
require 'active_support/all'
require 'sinatra/reloader' if development?
require_all 'creatures'
require_all 'actions'
require_all 'lands'
require_all 'abilities'
require_all 'phase'
require_relative 'fight'
require_relative 'player'
require_relative 'world'
require_relative 'battle'
require_relative 'turn'
require_relative 'deck'

class App <  Sinatra::Application

  configure do
    set :bind, '0.0.0.0'
    use Rack::Session::Pool
    set :session_secret, 'secret'
    set :views, Proc.new { File.join(root, "views") }
  end

  helpers do
    def h(text)
      Rack::Utils.escape_html(text)
    end

    def me
      session[:current_user]
    end

    def opponent
      $world.p1 == me ?  $world.p2 :  $world.p1
    end

  end


  @@players = []

  get "/" do
      session[:current_user] =  Player.new( name:"Player #{request.ip}") if me == nil
      if ! @@players.include? me
        @@players << me
      end
      @players = @@players
      erb :home
  end

  get "/multiplayer" do
      p1 = me
      p2 = Player.find(params[:opponent])
      p1.setup!
      p2.setup!

      notify!
      $world  = World.new(p1 , p2)
      redirect "/game"
  end


  get "/game" do
    redirect "/clear" if ! $world
    @world = $world
    erb :game , layout: !request.xhr?
  end

  get "/next" do
    $world.turn.next! if ( me.playing? &&  !$world.turn.phase.is_a?(BlockPhase) ) || ( !me.playing? &&  $world.turn.phase.is_a?(BlockPhase) )
    notify!
    redirect "/game"
  end


  get "/clear" do
    $world = nil
    @@players = []
    session.clear
    notify!
    redirect "/"
  end

  get "/action/:action_id/?:target_id?" do
    action  = Action.find(params[:action_id])
    if !params[:target_id]
      action.execute!
      $world.logs << action.log
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
    $world.target_action = nil
    notify!
    redirect "/game"
  end

  get '/auto' do
    me.auto_play! if ( me.playing? &&  !$world.turn.phase.is_a?(BlockPhase) ) || ( !me.playing? &&  $world.turn.phase.is_a?(BlockPhase) )
    notify!
    redirect "/game"
  end

  get '/auto_play' do
    me.auto_play!
    notify!
    redirect "/game?auto_play=true" if params[:auto_play]
    redirect "/game"
  end



  get '/cards' do
    $world = World.new(Player.new,Player.new )
    @cards=[]
    Creature.all.each do |card_class|
        card = card_class.new
        card.owner = $world.p1
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
