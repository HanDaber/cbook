#require "./app"
#run Sinatra::Application

root = ::File.dirname(__FILE__)
require ::File.join( root, './app' )
require "./app"
run CollegeBook