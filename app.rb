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

# Extend request object to handle pjax requests
class Sinatra::Request
    def pjax?
        env['HTTP_X_PJAX'] || self["_pjax"]
    end
end

# Application Class
class CollegeBook

    # Import the MongoMapper::Document Class
    include MongoMapper::Document
    
    private
    helpers do
        include Rack::Utils
        alias_method :h, :escape_html
    end
end

# User Class
class User < CollegeBook
    
    key :name,          String, required: true
    key :email,         String, required: true
    key :pass,          String, required: true
    key :created_at,    DateTime

    many :posts
    many :tags
end

class Post < CollegeBook
    
    key :text,  String, required: true
    
    belongs_to :user
    one :tag
end

class Tag < CollegeBook

    key :name, String, required: true
    
    belongs_to :post
end

class BulletinBoard < CollegeBook
    
    key :name,  String, required: true
    key :desc,  String, required: true
    
    many :posts
    many :tags
end

# URL routing and helper functions
require_relative 'routes/init'
require_relative 'helpers/init'