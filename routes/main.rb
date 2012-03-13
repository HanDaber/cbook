get "/" do
  @title = "Welcome to MyApp"        
  haml :index
end

not_found do
  html :'404'
end