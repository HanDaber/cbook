require 'mongo_mapper'

enable :sessions

get "/login" do
  @title  = "Login"
  haml :index
end

post "/login" do
  user = params[:name]
  pass = params[:pass]
  #found_user = User.where(:name => @user)
  valid_user = ["Martha", "pass"]
  if user == valid_user[0]
    if pass == valid_user[1]
      session[:user] = user
      redirect :main
    else
      haml <<"EOT", :layout => :layout
%h1{style:"color:#e00"} Wrong password, please go back and try again.
EOT
    end
  else
      haml <<"EOT", :layout => :layout
%h1{style:"color:#e00"} Username not found, please go back and try again.
EOT
  end
end

post "/signup" do
  name = params[:name]
  email = params[:email]
  pass = params[:pass]
#  @new_user = User.new()
#  @new_user.name = name
#  @new_user.email = email
#  @new_user.pass = pass
#  @new_user.created_at = Time.now
      
#  if @new_user.save
  if 1
    session[:user] = name
#      session[:user] = @new_user.name
    redirect :main
  else
    haml <<"EOT", :layout => :layout
%h1{style:"color:#e00"} Something went wrong, please go back and try again.
EOT
  end
end

get "/logout" do
  session[:user] = session[:pass] = nil
  redirect '/'
end