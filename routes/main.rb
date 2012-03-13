get "/" do
  @title = "Welcome to MyApp"        
  haml :index
end

get "/main" do
  @title = "Welcome to MyApp"        
  haml :main
end

get '/:name' do
  haml <<"EOT", :layout => !request.pjax?
%p Hello, #{params[:name]}!
%p= Time.now.strftime("You loaded this part at %Y/%m/%d %H:%M:%S.")
EOT
end

not_found do
  haml :e404
end