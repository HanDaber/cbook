class User < CollegeBook

    key :name,          String,     required: true, unique: true
    key :email,         String,     required: true, unique: true#, format: /^[A-Z0-9._]+@mit\.edu$/i
    key :pass,          String,     required: true#,               format: /[A-Za-z0-9_]{3,16}/
    key :bio,           String
    # key :passwd_digest, String,     required: true
    timestamps!

    many :posts
    many :tags, :as => :taggable
    
    def home
        return "#{self.name}/home"
    end

    def relevant_posts
        tags = self.tags
        @posts = []
        
        all_posts = Post.all
        all_posts.each do |post|
            show_post = false

            tags.each do |tag|
                post.post_tags.each { |t| show_post = true if t[1] == tag.name && post.user != self }
            end

            if show_post
                @posts << post
            end
        end
        unless @posts
            @posts = {text: "nil", post_tags: "nil"}
        end
    end
    
    def err
        arr = []
        self.errors.map { |k,v| arr.push("#{k} #{v}") }
        return arr
    end
           
end