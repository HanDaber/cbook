# CollegeBook rack app
# Dan Haber 3/2012
# 
# 
# 
require 'rubygems'
require 'sinatra/base'
require 'mongo_mapper'
require 'bundler/setup'
require_relative 'lib/helpers'
require_relative 'lib/compass/config'
require_relative 'lib/mongodb/config'

Bundler.require(:default)

# 
# 
# 
# # Required libraries
# require 'rubygems'
# # Sinatra is a small framework that provides URL routing and some helper functions
# require 'sinatra'
# # HTML templating with HAML preprocessor
# require 'haml'
# # CSS function library & preprocessor
# require 'sass'
# require 'sass/plugin/rack'
# # MongoDB is a small document database
# require 'mongo'
# # MongoMapper provides an Object-Relational Model (ORM) between our classes and MongoDB
# require 'mongo_mapper'
# # Configure MongoMapper
# require_relative 'configs/mongo'

class Web < Sinatra::Base
    
    helpers Helpers
    helpers Sinatra::ContentFor
    include Rack::Utils
    alias_method :h, :escape_html

    app_dir = self.root

    enable  :sessions,      :static,        :clean_trace,   :inline_templates
    set     :root,          app_dir
    set     :environment,   ENV['RACK_ENV'].to_sym if ENV['RACK_ENV']
    set     :public_folder, app_dir + '/web/public'
    set     :views,         app_dir + '/web/views'
    set     :sass,          { :style => :compressed, :debug_info => false   }
    set     :haml,          { :format => :html5,     :ugly => true          }
    
    # # 404 error route
    not_found do
        haml :e404, :layout => false
    end
    
    get '/' do
        if user_session # true returns @user
            redirect @user.home
        else
            show :index
        end
    end

    get '/logout/?' do
        destroy_session

        redirect '/'
    end

    get '/boards/?' do
        user_session

        @full_net = CollegeBook.net

        show :all_boards
    end
    
    get '/:board/?' do |name|
        if Board.enabled name
            @board = Board.find_or_create_by_name(name)
        else
            @board = false
        end

        if @board 
            @posts = @board.tagged_posts || []
        end

        if user_session && @board
            @add_tag_option = true

            @user.tags.each do |tag|
                if tag.name == @board.name
                    @add_tag_option = false
                end
            end
        end

        @login_option = true unless user_session

        show :board
    end
    
    get '/:user/home/?' do |username|
        if user_session
            @tags = @user.tags
            @posts = @user.relevant_posts

            show_me username, :home
        else
            redirect '/'
        end
    end
    
    get '/:user/posts/?' do |username|
        if user_session
            @posts = @user.posts.all

            show_me username, :posts
        else
            redirect '/'
        end
    end

    post '/:user/post' do
        if user_authenticated

            post_text = params[:post]
            post_tags = params[:tag]

            new_post = @user.posts.create({text: post_text})

            post_tags.map do |t|
                new_post.tags << t
            end if post_tags

            unless new_post.save
                session[:stat] = { status: false, msg: "Could not save post..." }
                redirect '/'
            end

            make_session
            redirect @user.home
        else
            session[:stat] = { status: false, msg: "Could not authenticate user..." }
            redirect '/'
        end
    end
    
    get '/:user/net/?' do |username|
        if user_session
            @tags = @user.tags

            show_me username, :net
        else
            redirect '/'
        end
    end

    post '/:user/tags' do
        if user_authenticated && allow_new_tags
            submitted_tags = params[:tag]
            saved_tags = @user.add_tags submitted_tags

            make_session

            if saved_tags == false
                session[:stat] = { status: false, msg: "You already follow those tags." }
            else
                session[:stat] = { status: true, msg: "#{saved_tags.length} of #{submitted_tags.length} tags saved." }
            end

            redirect @user.home
        else
            session[:stat] = { status: false, msg: "Could not authenticate user" }
            redirect '/'
        end
    end

    get '/:user/prefs/?' do |username|
        if user_session
            @tags = @user.tags
            @posts = @user.posts.all

            show_me username, :prefs
        else
            redirect '/'
        end
    end

    post '/:user/prefs' do
        if user_authenticated
            user_bio = params[:bio]

            unless @user.update_attributes!(bio: user_bio)
                session[:stat] = { status: false, msg: "Error editing preferences." }
                redirect @user.home
            end

            make_session
            redirect @user.home
        else
            session[:stat] = { status: false, msg: "Could not authenticate user" }
            redirect '/'
        end
    end
    
    post "/login/?" do
        if user_authenticated
            make_session
            redirect @user.home
        else
            session[:stat] = { status: false, msg: "Incorrect Username or Password..." }
            redirect '/'
        end 
    end

    post "/signup/?" do
        new_user_hash = {
            name: params[:name],
            email: params[:email],
            pass: params[:pass]
        }

        new_user = User.create(new_user_hash)

        if new_user.save   # returns false if new_user fails any validations
            @user = new_user
            make_session
            session[:stat] = { status: true, msg: "Welcome to CollegEbook, #{@user.name}" }
            redirect @user.home
        else
            session[:stat] = { status: false, msg: "Couldn't create user: #{new_user.err}" }
            redirect '/'
        end
    end
    
end

# Include our classes
require_relative 'classes/collegebook'
require_relative 'classes/board'
require_relative 'classes/post'
require_relative 'classes/comment'
require_relative 'classes/tag'
require_relative 'classes/user'

# URL routing
# require_relative 'routes/init'