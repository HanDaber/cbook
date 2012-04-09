post '/:user_name/post' do
    if user_authenticated
        
        post_text = params[:post]
        post_tags = params[:tag]

        new_post = @user.posts.create({text: post_text})
        
        post_tags.map do |t|
            new_post.post_tags << t
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

post '/:user_name/tag' do
    if user_authenticated
        
        tag_name = params[:tag]
        
        tag_exists = false
        
        @user.tags.each do |t|
            if t.name == tag_name
                tag_exists = true
            end
        end
        
        if tag_exists
            session[:stat] = { status: false, msg: "You already have that tag." }
            redirect @user.home
        else
            new_tag = @user.tags.create({name: tag_name})
            unless new_tag.save
                session[:stat] = { status: false, msg: "Error saving tag." }
                redirect @user.home
            end
            
            make_session
            redirect @user.home
        end
    else
        session[:stat] = { status: false, msg: "Could not authenticate user" }
        redirect '/'
    end
end

post '/:user_name/prefs' do
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