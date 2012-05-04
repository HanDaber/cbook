# desc 'Set up dev workflow'
task :install do
    system "bundle install"
end

desc 'Start the application'
task :start do
  system "bundle exec shotgun config.ru -p 9988"
end