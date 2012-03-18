get '/' do
    if session[:name]
        params[:user] = session[:name]
        route_to(:home)
    else
        haml :index
    end
end

get '/:user/home' do
    route_to(:home)
end

get '/:user/posts' do
    route_to(:posts)
end

get '/:user/tags' do
    route_to(:tags)
end


get '/:user/prefs' do
    route_to(:prefs)
end

get '/:board' do
    board_tag = params[:board]
    board = Board.find_by_name(board_tag)
    
    @board = Board.create()
    @board.name = board_tag
    
    if session[:name] && session[:pass]
        @user = User.find_by_name(session[:name])
    else
        @login = true
    end
    
    if board
        @board = board
        @show = true
    else
        @create = true
    end
    haml :board
    
end

# Avoid namespaced css/js requests
get '/:word/*.*' do
    redirect "/#{params[:splat][0]}.#{params[:splat][1]}"
end


# post routes ======================================================= #


post '/:user/post' do
    @who = params[:user]
    @pass = params[:pass]
    found_user = User.find_by_name(@who)
        
    @post_text = params[:post]
    @post_tag = params[:tag]

    if found_user
        if found_user[:pass] == @pass
            @user = found_user
            new_post = @user.posts.create()
            new_post.text = @post_text
            new_post.tag.name = @post_tag
            
            unless new_post.save
                error_string_haml("Post save fail.")
            end

            session[:stat] = {status: new_post.save, msg: "Success?"}
            redirect "#{found_user.name}/home"
        else
            error_string_haml("Wrong password, please go back and try again.")
        end
    else
        error_string_haml("Username not found, please go back and try again.")
    end
end

post '/:user/tag' do
    @who = params[:user]
    @pass = params[:pass]
    found_user = User.find_by_name(@who)
    
    @tag_name = params[:tag]

    if found_user
        if found_user[:pass] == @pass
            @user = found_user
            new_tag = @user.tags.create()
            new_tag.name = @tag_name
            
            unless new_tag.save
                error_string_haml("Post save fail.")
            end
            
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
    @who = params[:user]
    @pass = params[:pass]
    found_user = User.find_by_name(@who)
    
    @user_bio = params[:bio]

    if found_user
        if found_user[:pass] == @pass

            session[:stat] = {status: found_user.update_attributes!(:bio => user_bio), msg: "Success?"}
            redirect "#{found_user.name}/home"
        else
            error_string_haml("Wrong password, please go back and try again.")
        end
    else
        error_string_haml("Username not found, please go back and try again.")
    end
end

post '/board/new' do
    @who = params[:user]
    @pass = params[:pass]
    found_user = User.find_by_name(@who)
    
    @board_name = params[:board_name]
    @board_desc = params[:board_desc]
    
    if found_user
        if found_user[:pass] == @pass
            
            new_board = Board.create()
            new_board.name = @board_name
            new_board.desc = @board_desc
            
            unless new_board.save
                error_string_haml("Post save fail.")
            end
            
            session[:stat] = {status: new_board.save, msg: "Success?"}
            redirect "#{@board_name}"
        else
            error_string_haml("Wrong password, please go back and try again.")
        end
    else
        error_string_haml("Username not found, please go back and try again.")
    end
end