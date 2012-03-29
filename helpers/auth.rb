def authenticate_user(name, pass)
    found_user = User.find_by_name(name)

    if found_user && found_user[:pass] == pass
        return true
    else
        return false
    end
end