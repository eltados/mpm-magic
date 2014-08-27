#!/usr/bin/env ruby

require 'rubygems'
require 'sinatra'
require 'json'
require 'sinatra/reloader' if development?
require_relative 'creature'
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

    def other
      @p2 if $world.p1 == me
      @p1 if $world.p2 == me
      @p2
    end

  end

  def notify!(msg={})
  #Add the timestamp to the notification
    notification = msg.to_json

    @@notifications << notification

    @@notifications.shift if @@notifications.length > 10
    @@connections.each { |out| out << "data: #{notification}\n\n"}
  end


  @@connections = []
  @@notifications = []

  get "/" do
    @world = $world
    redirect "/start/1" if ! $world
    erb :home
  end

  get "/next" do
    $world.turn.next!
    notify!
    redirect "/"
  end


  get "/reset" do
    $world = nil
    redirect "/automatch"
  end



  get "/start/:player_number" do
    session.clear
    $world = World.new if ! $world
    session[:current_user] =  Player.new( name:"Player #{params[:player_number]}")
    me.setup!
    $world.p1 = me if params[:player_number].to_i == 1
    $world.p2 = me if params[:player_number].to_i == 2
    $world.playing_player = $world.p1
    redirect "/"
  end


  get "/end" do
    $world.turn.end_turn!
    redirect "/"
  end


  get "/action/:action_id" do
    action  = Action.find(params[:action_id])
    notify!
    action.execute!
    redirect "/"
  end

  get "/attack_all" do
    me.attack_all!
    notify!
    redirect "/"
  end



  get '/auto_play' do
    me.auto_play!
    notify!
    redirect "/?auto_play=true" if params[:auto_play]
    redirect "/"
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
end




# use ExceptionHandling
