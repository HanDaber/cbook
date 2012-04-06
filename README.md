CollegEbook
====================

A Source Repository
---------------------

Repo for cbook app

### More Info
> Ruby 1.9.2
> Application is run using 'rackup Config.ru' or 'ruby app.rb' 

<pre>
URL request from browser (http://cbook...com/:a/:b/:c)
    |
    --> [web server ('Thin')] => [Rack] => app.rb
        |
        --> routes/init.rb => {login.rb, main.rb...} \<= [Sinatra]
</pre>
