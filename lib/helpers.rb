module Helpers

    def partial page, options = {}
        haml "partials/_#{page}".to_sym, options.merge!(:layout => false)
    end
    
    def show page, options = {}
        default = {:layout => :'layouts/layout'}
        haml page.to_sym, default.merge!(options)
    end
    
    def show_me name, page
        if @user.name == name
            show page
        else
            redirect "#{@user.name}/#{page}"
        end
    end

    # Create a session
    def make_session
        session[:stat] = {status: true, msg: "Success"}
        session[:name] = @user.name
        session[:email] = @user.email
        session[:pass] = @user.pass
    end

    # Nillify session data
    def destroy_session
        [:name, :email, :pass].map do |prm|
            session[prm] = nil
        end
    end

    # Check for active session
    def user_session
        if session[:name] && session[:pass]
            session_hash = { name: session[:name], pass: session[:pass] }
            @user = User.first(session_hash)
            return true
        else
            return false
        end
    end

    # Check user credentials
    def user_authenticated
        if params[:name] && params[:pass]
            params_hash = { name: params[:name], pass: params[:pass] }
            @user = User.first(params_hash)
            if @user
                return true
            else
                return false
            end
        else
            return false
        end
    end

    # Key for creating new tags
    def allow_new_tags
        return true
    end
    
    # Some ugly errors
    def error_string_haml str
        return haml <<"EOT", :layout => :layout
%h1{style:"color:#e00;font-size:16pt;margin:1em 2em;"}= "#{str}"
EOT
    end

end