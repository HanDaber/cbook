# CollegeBook rack app
# Dan Haber 3/2012
# 

# Required libraries
require 'rubygems'
# Sinatra is a small framework 
# => that provides URL routing 
# => and some helper functions
require 'sinatra'
# HTML Templating with HAML
require 'haml'
# CSS function library
require 'sass'
require 'sass/plugin/rack'
# MongoDB is a small document database engine
require 'mongo'
# MongoMapper provides an Object-Relational Model 
# => between our Classes and MongoDB
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
    
    # Import the MongoMapper::Document Class
    include MongoMapper::Document
    require_relative 'configs/mongo'

    key :name, String, :required => true
    key :email, String, :required => true
    key :pass, String, :required => true
    key :created_at, Date

end

# URL routing and helper functions
require_relative 'routes/init'
require_relative 'helpers/init'