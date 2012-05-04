namespace :styles do

    web_dir = "web"
    sass_precomp_dir = "web/styles"
    css_public_dir = "web/public/stylesheets"
    img_dir = "web/public/img"
    js_dir = "web/public/js"
    preferred_syntax    = :scss
    line_comments       = false
    output_style        = :compressed
    
    desc "Create new compass project in #{sass_precomp_dir} and set public styles directory to #{css_public_dir}"
    task :new do
        system "compass create lib/compass --sass-dir=../../#{sass_precomp_dir} --css-dir=../../#{css_public_dir} --images-dir=../../#{img_dir} --javascripts-dir=../../#{js_dir} --syntax=scss --output-style=compressed --no-line-comments --bare"
    end
    
    desc "Watch the styles in ./web/styles/ and compile new changes to ./web/public/styles/"
    task :watch do
        system "compass watch lib/compass"
    end
end