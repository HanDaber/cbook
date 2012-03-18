get "/" do
    @title = "Welcome to CollegeBook"
    if session[:name]
        name = session[:name]
        # email = session[:email]
        # since = session[:since]
        # pass = session[:pass]
        # @user = {:name => name, :email => email, :since => since}
        # haml :home
        redirect "#{name}/home"
    else
        haml :index
    end
end

get "/:user/home" do
    if session[:name]
        user = User.find_by_name(session[:name])
        if user
            @posts = user.posts.all
            @tags = user.tags.all
            @user = user#{name: user.name, email: user.email, since: user.created_at}
            haml :home
        else
            not_found
        end    
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
    post_tag = params[:tag]

    found_user = User.find_by_name(name)

    if found_user && found_user[:name] == name
        if found_user[:pass] == pass
            @user = found_user
            new_post = @user.posts.create()
            new_post.text = post_text
            new_post.tag = {name: post_tag}
            
            unless new_post.save
                error_string_haml("Post save fail.")
            end
            
            # @post = new_post
            # new_post_tag = @post.tag.create()
            # new_post_tag.name = post_tag

            session[:stat] = {status: new_post.save, msg: "Success!"}
            redirect "#{found_user.name}/home"
        else
            error_string_haml("Wrong password, please go back and try again.")
        end
    else
        error_string_haml("Username not found, please go back and try again.")
    end
end

post '/:user/tag' do
    name = params[:user]
    pass = params[:pass]
    tag_name = params[:tag]

    found_user = User.find_by_name(name)

    if found_user && found_user[:name] == name
        if found_user[:pass] == pass
            @user = found_user
            new_tag = @user.tags.create()
            new_tag.name = tag_name

            session[:stat] = {status: new_tag.save, msg: "Success?"}
            redirect "#{found_user.name}/home"
        else
            error_string_haml("Wrong password, please go back and try again.")
        end
    else
        error_string_haml("Username not found, please go back and try again.")
    end
end

post '/:user/prefs' do
    name = params[:user]
    pass = params[:pass]
    user_bio = params[:bio]

    found_user = User.find_by_name(name)

    if found_user && found_user[:name] == name
        if found_user[:pass] == pass

            session[:stat] = {status: found_user.update_attributes!(:bio => user_bio), msg: "Success?"}
            redirect "#{found_user.name}/home"
        else
            error_string_haml("Wrong password, please go back and try again.")
        end
    else
        error_string_haml("Username not found, please go back and try again.")
    end
end

# Duct-taped Bulletin Boards for now
get '/:user/:board' do
    redirect "/#{params[:board]}"
end

get '/:board' do
    @name = params[:board]
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