# CollegeBook rack app
# Dan Haber 3/2012
# 

# Required libraries
require 'rubygems'
# Sinatra is a small framework that provides URL routing and some helper functions
require 'sinatra'
# HTML Templating with HAML
require 'haml'
# CSS function library
require 'sass'
require 'sass/plugin/rack'
# MongoDB is a small document database engine
require 'mongo'
# MongoMapper provides an Object-Relational Model between our Classes and MongoDB
require 'mongo_mapper'
require_relative 'configs/mongo'

enable :sessions

# Application Class
class CollegeBook

    # Import the MongoMapper::Document Class
    include MongoMapper::Document
    safe

    helpers do
        include Rack::Utils
        alias_method :h, :escape_html
    end
end

require_relative 'classes/board'
require_relative 'classes/user'
require_relative 'classes/post'
require_relative 'classes/tag'

# URL routing and helper functions
require_relative 'helpers/init'
require_relative 'routes/init'