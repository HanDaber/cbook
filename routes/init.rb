require 'mongo_mapper'

enable :sessions

# Some beautiful errors
def error_string_haml(str)
    return haml <<"EOT", :layout => :layout
%h1{style:"color:#e00;font-size:16pt;margin:1em 2em;"}= "#{str}"
EOT
end

# Generalized get route
def route_to(loc)
    @page = loc
    # params[] is a hash containing parameters passed in via URL
    @who = params[:user]
    # session[] is a mutable hash of parameters stored as a cookie on the user's browser
    @name = session[:name]
    
    if @name && @name == @who
        user = User.find_by_name(@name)
        
        if user
            @posts = user.posts.all
            @tags = user.tags.all
            @user = user
            haml @page
        else
            redirect "/"
        end
    else
        redirect "/"
    end
end

# 404 error route
not_found do
    haml :e404
end


require_relative 'login'
require_relative 'users'
require_relative 'home'