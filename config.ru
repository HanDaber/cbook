#require "./app"
#run Sinatra::Application

root = ::File.dirname(__FILE__)
require ::File.join( root, 'app' )
run Sinatra::Application::CollegeBook.new