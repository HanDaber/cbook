get "/" do
  @title = "Welcome to CollegeBook"
  haml :index
end

get "/main" do
  haml :main
end

get '/:name' do
  haml <<"EOT", :layout => !request.pjax?
%h1 #{params[:name]} Bulletin Board
%h3 Testing...
%p= Time.now.strftime("Debug: loaded@ %Y/%m/%d %H:%M:%S.")
EOT
end

not_found do
  haml :e404
end