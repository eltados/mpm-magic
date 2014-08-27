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

    def opponent
      $world.p1 == me ?  $world.p2 :  $world.p1
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
    redirect "/connecting" if ! $world || ! $world.ready?
    erb :home
  end

  get "/next" do
    $world.turn.next! if me.playing?
    notify!
    redirect "/"
  end


  get "/reset" do
    $world = nil
    session.clear
    "Wait for the opponent to logout out and then press <a href='/'>Connect</a>" 
  end

  get "/connecting" do
    $world = World.new if ! $world
    if $world.p1 == nil
      session[:current_user] =  Player.new( name:"Player 1")
      me.setup!
      $world.p1 = me
      $world.playing_player = $world.p1
    elsif !me
      session[:current_user] =  Player.new( name:"Player 2")
      me.setup!
      $world.p2 = me
    end
    redirect "/" if $world.ready?
    erb :connecting
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
