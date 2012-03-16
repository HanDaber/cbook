get "/" do
    @title = "Welcome to CollegeBook"
    if session[:name]
        name = session[:name]
        email = session[:email]
        since = session[:since]
        pass = session[:pass]
        @user = {:name => name, :email => email, :since => since}
        # haml :home
        redirect "#{name}/home"
    else
        haml :index
    end
end

get "/:user/home" do
    if session[:name]
        name = session[:name]
        email = session[:email]
        since = session[:since]
        @user = {:name => name, :email => email, :since => since}
        haml :home        
    else
        redirect "/"
    end
end

get '/:user/posts' do
    if session[:name] && session[:name] == params[:user]
        user = User.find_by_name(session[:name])
        if user
            @posts = user.posts.all
            @user = {name: user.name, email: user.email, since: user.created_at}
            haml :posts
        else
            not_found
        end
    else
        redirect '/'
    end
end

get '/:user/tags' do
    if session[:name] && session[:name] == params[:user]
        user = User.find_by_name(session[:name])
        if user
            @tags = user.tags.all
            @user = {name: user.name, email: user.email, since: user.created_at}
            haml :tags
        else
            not_found
        end
    else
        redirect '/'
    end
end

get '/:user/prefs' do
    if session[:name] && session[:name] == params[:user]
        user = User.find_by_name(session[:name])
        if user
            @posts = user.posts.all
            @tags = user.tags.all
            @user = {name: user.name, email: user.email, since: user.created_at}
            haml :prefs
        else
            not_found
        end
    else
        redirect '/'
    end
end

# Duct-taped Bulletin Boards for now
get '/:name' do
    @name = params[:name]
    haml :board
end

# Avoid namespaced css/js requests
get '/:word/*.*' do
    redirect "/#{params[:splat][0]}.#{params[:splat][1]}"
end

# 404 error route
not_found do
    haml :e404
end