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
    enable :sessions
    set :views, Proc.new { File.join(root, "views") }
  end

  helpers do
    def h(text)
      Rack::Utils.escape_html(text)
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
    erb :home
  end

  get "/next" do
    $world.turn.next!
    notify!
    redirect "/"
  end


  get "/reset" do
    $world = World.setup
    notify!
    redirect "/"
  end

  get "/start" do
    session[:current_user] = $world.current_player
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
    $world.current_player.attack_all!
    notify!
    redirect "/"
  end

  get '/auto_play' do
    $world.current_player.auto_play!
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
