# Duct-taped error messages for now
post "/login" do
    name = params[:name]
    pass = params[:pass]
    
    found_user = User.find_by_name(name)

    if found_user
        if found_user[:pass] == pass
            session[:name] = found_user.name
            session[:email] = found_user.email
            session[:pass] = found_user.pass

            redirect "#{found_user.name}/home"
        else
            error_string_haml("Wrong password, please go back and try again.")
        end
    else
        error_string_haml("Username not found, please go back and try again.")
    end
end

post "/signup" do
    name = params[:name]
    email = params[:email]
    pass = params[:pass]
    
    found_user = User.find_by_name(name)
    
    if found_user
        error_string_haml("User already exists, please go back and try a different name.")
    else 
        new_user = User.create()
        new_user.name = name
        new_user.email = email
        new_user.pass = pass
        new_user.created_at = Time.now()
        
        if new_user.save
            session[:name] = new_user.name
            session[:email] = new_user.email
            # Totally not secure, sending password in plaintext:
            session[:pass] = new_user.pass
            session[:since] = new_user.created_at
            redirect "#{new_user.name}/home"
        else
            error_string_haml("Something went wrong, please go back and try again.")
        end
    end
end

get "/logout" do
    session[:name] = session[:pass] = nil
    redirect '/'
end