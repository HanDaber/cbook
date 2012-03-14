require 'rubygems'
require 'sinatra'
require 'log_buddy'

require 'haml'
Haml::Template.options[:format] = :html5

require 'sass'

require 'sass/plugin/rack'
use Sass::Plugin::Rack
set :sass, {:style => :compressed}

root_dir = File.dirname(__FILE__)
app_file = File.join(root_dir, 'app.rb')

set :environment, ENV['RACK_ENV'].to_sym
set :root,        root_dir
set :app_file,    app_file
disable :run

require 'mongo_mapper'
require 'mongo_config'

require app_file

run CollegeBook.new