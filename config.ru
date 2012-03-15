root_dir = File.dirname(__FILE__)

app_file = File.join(root_dir, 'app.rb')

set :environment, ENV['RACK_ENV'].to_sym
set :root,        root_dir
set :app_file,    app_file
disable :run

require app_file

Haml::Template.options[:format] = :html5

use Sass::Plugin::Rack
set :sass, {:style => :compressed}

#run CollegeBook.new
run app_file