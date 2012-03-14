# CollegeBook rack app
# Dan Haber 3/2012
# 

require 'sinatra'
require 'haml'
require 'sass'
require 'mongo_mapper'

# Extend request object to handle pjax requests
class Sinatra::Request
  def pjax?
    env['HTTP_X_PJAX'] || self["_pjax"]
  end
end

class User
  include MongoMapper::Document
  
  key :name, String, :required => true
  key :email, String, :required => true
  key :pass, String, :required => true
end

# Application Class
class CollegeBook < Sinatra::Application
  enable :sessions

  configure :production do
    set :haml, { :ugly=>true }
    set :clean_trace, true
  end

  configure :development do
    # ...
  end

  helpers do
    include Rack::Utils
    alias_method :h, :escape_html
  end
  
  require_relative 'routes/init'
  
end

require_relative 'models/init'
require_relative 'helpers/init'