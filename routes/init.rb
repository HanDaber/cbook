# Some beautiful errors
def error_string_haml(str)
    return haml <<"EOT", :layout => :layout
%h1{style:"color:#e00;font-size:16pt;margin:1em 2em;"}= "#{str}"
EOT
end

# Nillify session data
def log_out
    [:name, :email, :pass].map { |a| session[a] = nil }
end

# 404 error route
not_found do
    haml :e404, :layout => false
end

# Check if there is an active session (a user is logged in)
before do
    session_hash = {name: session[:name], pass: session[:pass]}
    if session_hash
        @session = true
        @user = User.first(session_hash)
        unless @user
            # Reset session just in case it is corrupt
            log_out
            session[:stat] = {status: @session, msg: "User not found."}
            haml :index
        end
    else 
        @session = false
        log_out
        session[:stat] = {status: @session, msg: "You are not logged in."}
        haml :index
    end
end

# 
# 
# # Generalized get route
# def route_to(loc)
# 
#     @page = loc
#     
#     
#     
#     # params[] is a hash containing parameters passed in via URL
#     @who = params[:user]
#     # session[] is a mutable hash of parameters stored as a cookie on the user's browser
#     @name = session[:name]
#     
#     if @name && @name == @who
#         user = User.find_by_name(@name)
#         
#         if user
#             @user = user
#             @tags = @user.tags
#             @posts = []
#             
#             if @page == :home
#                 
#                 all_posts = Post.all
# 
#                 all_posts.each do |post|
#                     show_post = false
#                     
#                     @tags.each do |tag|
#                         post.post_tags.each { |t| show_post = true if t[1] == tag.name && post.user != @user }
#                     end
# 
#                     if show_post
#                         @posts << post
#                     end
#                 end
#                 
#                 unless @posts
#                     @posts = {text: "nil", post_tags: "nil"}
#                 end
#             else
#                 @posts = user.posts.all
#             end
#             
#             haml loc
#         else
#             redirect "/"
#         end
#     else
#         redirect "/"
#     end
# end

require_relative 'routes'
require_relative 'login'
require_relative 'home'