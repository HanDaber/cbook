# 404 error route
not_found do
    haml :e404, :layout => false
end

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