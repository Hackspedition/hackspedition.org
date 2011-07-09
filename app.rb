require 'rubygems'
require 'sinatra'
require 'sinatra/content_for'
require 'sinatra/reloader' if development?
require 'haml'
require 'sass'
require 'rdiscount'

get '/' do
  haml :index
end

get '/nyc' do
  @title = "Hackspedition [NYC] New York City"
  haml :nyc
end

get '/vha' do
  @title = "Hackspedition [VHA] Villahermosa"
  haml :vha
end

get '/stylesheets/*' do
  content_type 'text/css'
  sass '../styles/'.concat(params[:splat].join.chomp('.css')).to_sym
end
