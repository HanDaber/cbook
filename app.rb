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

require_relative 'classes/collegebook'
require_relative 'classes/board'
require_relative 'classes/post'
require_relative 'classes/tag'
require_relative 'classes/user'

# URL routing and helper functions
require_relative 'helpers/init'
require_relative 'routes/init'