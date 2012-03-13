get 'stylesheets/styles.css' do
  header 'Content-Type' => 'text/css; charset=utf-8'
  scss :styles
end