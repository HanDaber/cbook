# CollegeBook rack app
# Dan Haber 3/2012
# 

# Required libraries
require 'rubygems'
require 'sinatra'
require 'haml'
require 'sass'
require 'sass/plugin/rack'
require 'mongo'
require 'mongo_mapper'

# Extend request object to handle pjax requests
class Sinatra::Request
    def pjax?
        env['HTTP_X_PJAX'] || self["_pjax"]
    end
end

# Application Class
class CollegeBook < Sinatra::Application

    helpers do
        include Rack::Utils
        alias_method :h, :escape_html
    end
  
end

# User Class
class User

    include MongoMapper::Document
    require_relative 'configs/mongo'

    key :name, String, :required => true
    key :email, String, :required => true
    key :pass, String, :required => true
    key :created_at, Date

end

require_relative 'routes/init'
require_relative 'helpers/init'