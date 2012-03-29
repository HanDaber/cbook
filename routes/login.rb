# Duct-taped error messages for now
post "/login" do
    name = params[:name]
    pass = params[:pass]
    
    auth_user = User.create({
        :name => name,
        :pass => pass,
        :email => "temp-#{Time.now.to_i}@mit.edu"
    })
    
    if auth_user.exists
        session = auth_user.build_session
        redirect auth_user.home
    else
        error_string_haml("User name not found. Please go back and try again.")
    end 
end



post "/signup" do
    name = params[:name]
    email = params[:email]
    pass = params[:pass]
    
    new_user = User.create({
        :name => name,
        :email => email,
        :pass => pass
    })
    
    if new_user
        if new_user.exists
            error_string_haml("User already exists, please go back and try a different name.")
        else
            if new_user.save
                session = new_user.build_session
                # redirect new_user.home
                error_string_haml("#{new_user.home}")
            else
                error_string_haml("Could not save user #{new_user}")
            end
        end
    else
        error_string_haml("Could not create new User #{new_user}")
    end
end



get "/logout" do
    session[:name] = session[:pass] = nil
    redirect '/'
end