# Duct-taped error messages for now
post "/login/?" do
    if user_authenticated
        make_session
        redirect @user.home
    else
        session[:stat] = { status: false, msg: "Incorrect Username or Password..." }
        redirect '/'
    end 
end

post "/signup/?" do
    new_user_hash = {
        name: params[:name],
        email: params[:email],
        pass: params[:pass]
    }

    @new_user = User.create(new_user_hash)

    if @new_user.save   # returns false if @new_user fails any validations
        redirect @new_user.home
    else
        session[:stat] = { status: false, msg: "Couldn't create user: #{@new_user.err}" }
        redirect '/'
    end
end