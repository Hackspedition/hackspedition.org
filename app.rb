require 'rubygems'
require 'sinatra'
require 'sinatra/content_for'
require 'sinatra/reloader' if development?
require 'dm-core'
require 'dm-migrations'
require 'dm-serializer'
require 'haml'
require 'sass'
require 'rdiscount'

DataMapper.setup(:default, ENV['DATABASE_URL'] || "sqlite3://#{Dir.pwd}/database.sqlite3")

class Subscriber
  include DataMapper::Resource
  property  :id,     Serial   
  property  :email,  String,  :required => true
  property  :event,  String,  :required => true
end

DataMapper.auto_upgrade!

get '/' do
  haml :index
end

get '/df' do
  @title = "Hackspedition [DF] Mexico City"
  haml :df
end

get '/sv' do
  @title = "Hackspedition [NYC] Silicon Valley"
  haml :sv
end

get '/nyc' do
  @title = "Hackspedition [NYC] New York City"
  haml :nyc
end

get '/tabasco' do
  @title = "Hackspedition [TAB] Tabasco"
  haml :tab
end

get '/organize' do
  @title = "Organize a Hackspedition"
  haml :organize
end

post '/subscribe' do
  @subscriber = Subscriber.create(params)
  halt 500 unless @subscriber.saved?
  redirect '/'
end

get '/team' do
  
end

get '/:event/subscribers' do
  if(params[:format] == 'json')
    content_type :json, 'charset' => 'utf-8'
    Subscriber.all(:event => params[:event]).to_json
  end
end

get '/stylesheets/*' do
  content_type 'text/css'
  sass '../styles/'.concat(params[:splat].join.chomp('.css')).to_sym
end
