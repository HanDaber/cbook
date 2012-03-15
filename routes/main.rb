get "/" do
    @title = "Welcome to CollegeBook"
    haml :index
end

get "/main" do
    if session[:user]
        haml :main
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