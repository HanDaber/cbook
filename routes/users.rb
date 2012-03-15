# Not working yet
get 'u/:name' do
    haml <<"EOT", :layout => false
%h1{style:"font-size:20pt;"} #{params[:name]} USER PAGE
%h3 Testing...
%p= Time.now.strftime("Debug: loaded@ %Y/%m/%d %H:%M:%S.")
EOT
end

get '/u/*.*' do |file, ext|
  redirect "/#{file}.#{ext}"
end