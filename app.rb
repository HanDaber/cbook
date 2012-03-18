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

    helpers do
        include Rack::Utils
        alias_method :h, :escape_html
    end
end

class Board < CollegeBook
    
    key :name,  String, required: true
    key :bio,   String, required: true
    
    many :posts
end

class User < CollegeBook
    
    key :name,          String,     required: true, unique: true
    key :email,         String,     required: true, unique: true, format: /^[A-Z0-9._]+@mit\.edu$/i
    key :pass,          String,     required: true
    key :bio,           String
    key :created_at,    DateTime,   required: true

    many :posts
    many :tags, :as => :taggable
end

class Post < CollegeBook
    
    key :text,      String, required: true
    key :post_tags, Array
    timestamps!
    
    belongs_to :user
    many :tags, :in => :post_tags, :as => :taggable
end

class Tag < CollegeBook
    
    key :name, String, required: true
    
    belongs_to :taggable, :polymorphic => true
    # belongs_to :post
end

# URL routing and helper functions
require_relative 'routes/init'
require_relative 'helpers/init'