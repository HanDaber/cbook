# Duct-taped error messages for now
post "/login" do
    user_hash = {
        name: params[:name],
        pass: params[:pass]
    }
    
    @found_user = User.first(user_hash)
    
    if @found_user
        [:name, :email, :pass].map { |a| session[a] = @found_user[a] }

        redirect @found_user.home
    else
        session[:stat] = {status: false, msg: "Incorrect Username or Password"}
        
        redirect "/"
    end 
end



post "/signup" do
    user_hash = {
        name: params[:name],
        email: params[:email],
        pass: params[:pass]
    }

    @new_user = User.create(user_hash)
    
    # .save runs validations
    if @new_user.save
        [:name, :email, :pass].map { |a| session[a] = @new_user[a] }

        redirect @new_user.home
    else
        session[:stat] = {status: false, msg: "Couldn't create user: #{@new_user.err}"}
        
        redirect "/"
    end
end