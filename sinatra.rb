#!/usr/bin/env ruby

require 'rubygems'
require 'sinatra'
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

  get "/" do
    @world = $world
    erb :home
  end

  get "/next" do
    $world.turn.next!
    redirect "/"
  end


  get "/reset" do
    $world = World.setup
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
    action.execute!
    redirect "/"
  end

  get "/attack_all" do
    $world.current_player.attack_all!
    redirect "/"
  end

  get '/auto_play' do
    $world.current_player.auto_play!
    redirect "/?auto_play=true" if params[:auto_play]
    redirect "/"
  end
end




# use ExceptionHandling
