# Default kick-off route to root/login
def render_root
    haml :index
end

def show name, page
    if @user.name == name
        haml page
    else
        redirect "#{@user.name}/#{page}"
    end
end

require_relative 'routes'
require_relative 'login'