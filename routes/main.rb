get "/" do
  @title = "Welcome to MyApp"        
  haml :index
end

not_found do
  haml :e404
end