get '/?' do
    if @user
        redirect @user.home
    else
        haml :index
    end
end

# Generalized route for user pages
get '/:user_name/:page/?' do |user_name, page|

    page_exists = false

    ['home', 'net', 'posts', 'tags', 'prefs'].map do |existing_page|
        if page == existing_page
            page_exists = true
        end
    end

    if page_exists && user_name == @user.name
        
        
        # Generate a session hash representing this user to send to the browser
        [:name, :email, :pass].map do |parameter|
            session[parameter] = @user[parameter]
        end
        
        @tags = @user.tags

        @posts = []
        if page == 'home'
            # TODO:
            # Very inefficient way to do this, should be doing comparison in the Model
            all_posts = Post.all
            all_posts.each do |post|
                show_post = false
            
                @tags.each do |tag|
                    post.post_tags.each { |t| show_post = true if t[1] == tag.name && post.user != @user }
                end

                if show_post
                    @posts << post
                end
            end
            unless @posts
                @posts = {text: "nil", post_tags: "nil"}
            end
        else
            @posts = @user.posts.all
        end
        
        
        haml page.to_sym
    else
        not_found
    end
end

get "/logout/?" do
    destroy_session
    
    redirect '/'
end

get '/:board/?' do |board_tag|

    board = Board.find_by_name(board_tag)
    
    @board = Board.create()
    @board.name = board_tag
    @posts = []
    
    if session[:name] && session[:pass]
        @user = User.find_by_name(session[:name])
        
        tags = @user.tags
        @has_tag = false
        tags.each { |t| @has_tag = true if t[1] == @board.name }
    else
        @login = true
    end
    
    if board
        @board = board
        
        all_posts = Post.all

        all_posts.each do |post|
            show_post = false
            post.post_tags.each { |t| show_post = true if t[1] == @board.name }

            if show_post
                @posts << post
            end
        end
        
        unless @posts
            @posts = { text: "nil", post_tags: "nil" }
        end
        
        @show = true
    else
        @create = true
    end
    haml :board
    
end