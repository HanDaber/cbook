# http://cbook.herokuapp.com
get '/' do
    if user_session
        redirect @user.home
    else
        render_root
    end
end

get '/logout/?' do
    destroy_session

    redirect '/'
end

# Redirect namespaced css/js requests
get '/*/*.*' do
    redirect "/#{params[:splat][1]}.#{params[:splat][2]}"
end

get '/:user_name/home/?' do |username|
    if user_session # true returns @user
        @tags = @user.tags
        @posts = @user.relevant_posts
        
        show username, :home
    else
        redirect '/'
    end
end

get '/:user_name/posts/?' do |username|
    if user_session
        @posts = @user.posts.all
        
        show username, :posts
    else
        redirect '/'
    end
end

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

get '/:user_name/net/?' do |username|
    if user_session
        @tags = @user.tags
        
        show username, :net
    else
        redirect '/'
    end
end

post '/:user_name/tags' do
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

get '/:user_name/prefs/?' do |username|
    if user_session
        @tags = @user.tags
        @posts = @user.posts.all
        
        show username, :prefs
    else
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

get '/:board_name/?' do |board_tag|

    if Board.enabled board_tag
        @board = Board.find_or_create_by_name(board_tag)
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
    
    haml :board
end

# post '/board/new' do
#     if user_authenticated
#         board_name = params[:board_name]
#         board_desc = params[:board_desc]
# 
#         new_board = Board.create({name: board_name, bio: board_desc})
#         
#         unless new_board.save
#             session[:stat] = { status: false, msg: "Error saving board"}
#         end
#         
#         make_session
#         redirect "/#{new_board.name}"
#     else
#         session[:stat] = { status: false, msg: "Could not authenticate user" }
#         redirect '/'
#     end
# end