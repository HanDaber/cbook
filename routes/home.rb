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

# Duct-taped Bulletin Boards for now
get '/:name' do
    
    haml <<"EOT", :layout => !request.pjax?
%h1{style:"font-size:20pt;"} #{params[:name]} Bulletin Board
%h3 Testing...
%p= Time.now.strftime("Debug: loaded@ %Y/%m/%d %H:%M:%S.")
EOT

end

not_found do
    haml :e404
end