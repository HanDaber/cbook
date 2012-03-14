require 'mongo_mapper'

enable :sessions

get "/login" do
  @title  = "Login"
  haml :index
end

post "/login" do
  @user = params[:user]
  @pass = params[:pass]
  found_user = User.find(@user)
  if @user == "martha" or @user == "Martha"
    if @pass == "pass"
      session[:user] = @user
      session[:pass] = @pass
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
  @new_user = User.create({
      :user => name,
      :email => email,
      :pass => pass,
      :created_at => Time.now
  })
  if @new_user.save
      session[:user] = @new_user
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