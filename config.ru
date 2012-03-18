# Rack is the interface between the web server and our app
# it will forward incoming requests from the server to our app, 
# and send responses from our app back to the web server to be...
# served. 

# Define environment variables ( __FILE__ = this very file )
root_dir = File.dirname(__FILE__)
app_file = File.join(root_dir, 'app.rb')
set :environment, ENV['RACK_ENV'].to_sym
set :root,        root_dir
set :app_file,    app_file
disable :run

# Require our application
require app_file

# Some configuration
    # Haml should compile to html5
Haml::Template.options[:format] = :html5
set :haml, { :ugly=>true }

    # Sass should compile without spaces (reduces file size)
use Sass::Plugin::Rack
set :sass, {:style => :compressed}

set :clean_trace, true

# run app.rb
run :app_file