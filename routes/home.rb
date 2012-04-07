



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
    @post_tags = params[:tag]

    if found_user.exists
        if found_user[:pass] == @pass

            new_post = found_user.posts.create({text: @post_text})
            
            new_post.post_tags = @post_tags.each { |t| t[1] } if @post_tags
            
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
            
            duh = false
            found_user.tags.each { |t| duh = true if t.name == @tag_name }
            if duh
                error_string_haml("You already have that tag.")
            else
                new_tag = found_user.tags.create({name: @tag_name})
                session[:stat] = {status: new_tag.save, msg: "Success?"}
                redirect "#{found_user.name}/home"
            end

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

            session[:stat] = {status: found_user.update_attributes!(:bio => @user_bio), msg: "Success?"}
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
            new_board.bio = @board_desc
            
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