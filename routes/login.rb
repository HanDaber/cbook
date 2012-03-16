require 'mongo_mapper'

enable :sessions

# get "/login" do
#     @title  = "Login"
#     haml :index
# end

# Duct-taped error messages for now
post "/login" do
    name = params[:name]
    pass = params[:pass]
    
    found_user = User.find_by_name(name)

    if found_user && found_user[:name] == name
        if found_user[:pass] == pass
            session[:name] = found_user.name
            session[:email] = found_user.email
            session[:pass] = found_user.pass
            session[:since] = found_user.created_at
            redirect "#{found_user.name}/home"
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
    
    new_user = User.create()
    new_user.name = name
    new_user.email = email
    new_user.pass = pass
    new_user.created_at = Time.now()
    
    found_user = User.find_by_name(name)
    
    if found_user
        haml <<"EOT", :layout => :layout
%h1{style:"color:#e00;font-size:16pt;margin:1em 2em;"} User already exists, please go back and try a different name.
EOT
    elsif new_user.save
        session[:name] = new_user.name
        session[:email] = new_user.email
        # Totally not secure, sending password in plaintext:
        session[:pass] = new_user.pass
        session[:since] = new_user.created_at
        redirect "#{new_user.name}/home"
    else
        haml <<"EOT", :layout => :layout
%h1{style:"color:#e00;font-size:16pt;margin:1em 2em;"} Something went wrong, please go back and try again.
EOT
    end
end

get "/logout" do
    session[:name] = session[:pass] = nil
    redirect '/'
end