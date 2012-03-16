get "/" do
    @title = "Welcome to CollegeBook"
    if session[:name]
        name = session[:name]
        email = session[:email]
        since = session[:since]
        pass = session[:pass]
        @user = {:name => name, :email => email, :since => since}
        # haml :home
        redirect :home
    else
        haml :index
    end
end

get "/home" do
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
        user = User.find_by_name(params[:user])
        if user
            @posts = user.posts.all
            haml "%h1{style:'color:#00e;font-size:16pt;margin:1em 2em;'}= \"#{@posts.length}\"", :layout => true
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

get '/:word/*.*' do
    redirect "/#{params[:splat][0]}.#{params[:splat][1]}"
end

not_found do
    haml :e404
end