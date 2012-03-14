enable :sessions

get "/login" do
  @title  = "Login"
  haml :index
end

post "/login" do
  @user = params[:user]
  @pass = params[:pass]
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

get "/logout" do
  session[:user] = session[:pass] = nil
  redirect '/'
end