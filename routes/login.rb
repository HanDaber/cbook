require 'mongo_mapper'

enable :sessions

get "/login" do
    @title  = "Login"
    haml :index
end

post "/login" do
    name = params[:name]
    pass = params[:pass]
    
    found_user = User.find_by_name(name)

    # valid_user = ["Martha", "pass"]
    # 
    if found_user && found_user[:name] == name
        if found_user[:pass] == pass
            session[:user] = found_user[:name]
            redirect :main
        else
            haml <<"EOT", :layout => :layout
%h1{style:"color:#e00;font-size:16pt;margin:1em 2em;"} Wrong password, please go back and try again.
EOT
        end
    else
        haml <<"EOT", :layout => :layout
%h1{style:"color:#e00;font-size:16pt;margin:1em 2em;"} Username not found, please go back and try again.
EOT
    end
end

post "/signup" do
    name = params[:name]
    email = params[:email]
    pass = params[:pass]
    
    new_user = User.new()
    new_user.name = name
    new_user.email = email
    new_user.pass = pass
    new_user.created_at = Time.now
    
    found_user = User.find_by_name(name)
    
    if found_user
        haml <<"EOT", :layout => :layout
%h1{style:"color:#e00;font-size:16pt;margin:1em 2em;"} User already exists, please go back and try a different name.
EOT
    elsif new_user.save
        session[:user] = new_user.name
        redirect :main
    else
        haml <<"EOT", :layout => :layout
%h1{style:"color:#e00;font-size:16pt;margin:1em 2em;"} Something went wrong, please go back and try again.
EOT
    end
end

get "/logout" do
    session[:user] = session[:pass] = nil
    redirect '/'
end