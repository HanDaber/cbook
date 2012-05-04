# # Rack is the interface between the web server and our app
# # it will forward incoming requests from the server to our app, 
# # (starting the app) and send responses from our app back to 
# # the web server to be...
# # served. 
# 
# # Define environment variables ( __FILE__ = config.ru )
# root_dir = File.dirname(__FILE__)
# app_file = File.join(root_dir, 'app.rb')
# set :environment, ENV['RACK_ENV'].to_sym
# set :root,        root_dir.to_sym
# 
# # Require our application (app.rb)
# require app_file
# 
# # Some middleware configurations
#     set :clean_trace, true
#     
#     # Haml should compile to html5
#     Haml::Template.options[:format] = :html5
#     set :haml, { :ugly=>true }
# 
#     # Sass should compile without spaces (reduces file size)
#     use Sass::Plugin::Rack
#     set :sass, {:style => :compressed}
# 
# # run app.rb
# run app_file

# Requires
require 'rubygems'
require 'bundler/setup'

Bundler.require(:default)

require File.dirname(__FILE__) + '/app.rb'

map '/' do
	run Web
end