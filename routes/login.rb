# Duct-taped error messages for now
post "/login/?" do
    if user_authenticated
        session[:name] = @user.name
        session[:email] = @user.email
        session[:pass] = @user.pass
        redirect @user.home
    else
        session[:stat] = { status: false, msg: "Incorrect Username or Password..." }
        redirect '/'
        # render_root
    end 
end



post "/signup/?" do
    new_user_hash = {
        name: params[:name],
        email: params[:email],
        pass: params[:pass]
    }

    @new_user = User.create(new_user_hash)
    
    # .save runs validations
    if @new_user.save
        redirect @new_user.home
    else
        session[:stat] = { status: false, msg: "Couldn't create user: #{@new_user.err}" }
        redirect '/'
        # render_root
    end
end