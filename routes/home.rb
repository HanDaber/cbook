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

post '/:user/post' do
    name = params[:user]
    pass = params[:pass]
    post_text = params[:post]
    
    found_user = User.find_by_name(name)

    if found_user && found_user[:name] == name
        if found_user[:pass] == pass
            @user = found_user
            new_post = @user.posts.create()
            new_post.text = post_text
            
            session[:stat] = {status: new_post.save, msg: "Success!"}
            redirect "#{found_user.name}/home"
        else
            haml <<"EOT", :layout => :layout
%h1{style:"color:#e00;font-size:16pt;margin:1em 2em;"} Wrong password, please go back and try again.
EOT
        end
    else
        haml <<"EOT", :layout => :layout
%h1{style:"color:#e00;font-size:16pt;margin:1em 2em;"} Username not found, please go back and try again.
EOT
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