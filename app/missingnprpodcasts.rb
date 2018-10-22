require 'rubygems'
require 'bundler/setup'

require 'haml'
require 'rack-google-analytics'
require 'sinatra'
require 'sinatra/assetpack'

require './app/podcast'


STORY_COUNT = 30

set :root, File.dirname(__FILE__)

use Rack::GoogleAnalytics,
  :tracker => 'UA-17416589-4',
  :multiple => true,
  :domain => 'nprpodcasts.herokuapp.com'

assets {
  serve '/js', from: 'js'
  serve '/css', from: 'css'

  js :app, '/js/app.js', ['/js/missingnprpodcasts.js']
  css :app, '/css/app.css', ['/css/missingnprpodcasts.css']

  js_compression :uglify, { :toplevel => true }
}

get '/' do
  @base_url = request.base_url
  @scheme = request.scheme
  haml :index
end

get '/testapikey' do
  api_key = params[:key]

  content_type 'text/json'
  Podcast.test_api_key api_key, logger
end

get '/podcasts/weekendsaturday' do
  podcast = Podcast.new :program_id => 7,
  :title => 'Weekend Edition Saturday',
  :api_key => params[:key],
  :story_count => STORY_COUNT,
  :program_image => 'https://nprpodcasts.herokuapp.com/images/custom_atc_logo.png',
  :logger  => logger

  content_type 'text/xml'
  podcast.build_rss
end

get '/podcasts/weekendsunday' do
  podcast = Podcast.new :program_id => 10,
  :title => 'Weekend Edition Sunday',
  :api_key => params[:key],
  :story_count => STORY_COUNT,
  :program_image => 'https://nprpodcasts.herokuapp.com/images/custom_atc_logo.png',
  :logger  => logger

  content_type 'text/xml'
  podcast.build_rss
end

get '/podcasts/morningedition' do
  podcast = Podcast.new :program_id => 3,
  :title => 'Morning Edition',
  :api_key => params[:key],
  :story_count => 40,
  :program_image => 'https://nprpodcasts.herokuapp.com/images/custom_morningedition_logo.jpg',
  :logger  => logger

  content_type 'text/xml'
  podcast.build_rss
end

get '/podcasts/allthingsconsidered' do
  podcast = Podcast.new :program_id => 2,
  :title => 'All Things Considered',
  :api_key => params[:key],
  :story_count => STORY_COUNT,
  :program_image => 'https://nprpodcasts.herokuapp.com/images/custom_atc_logo.png',
  :logger  => logger

  content_type 'text/xml'
  podcast.build_rss
end

get '/podcasts/sonjacast' do
  podcast = Podcast.new :program_id => 1125,1053,
  :title => 'Stories for Sonja',
  :api_key => params[:key],
  :story_count => STORY_COUNT,
  :program_image => 'https://nprpodcasts.herokuapp.com/images/custom_atc_logo.png',
  :logger  => logger

  content_type 'text/xml'
  podcast.build_rss
end
