class User < CollegeBook

    # Database model:
    key :name,          String,     required: true, unique: true
    key :email,         String,     required: true, unique: true#, format: /^[A-Z0-9._]+@mit\.edu$/i
    key :pass,          String,     required: true#,               format: /[A-Za-z0-9_]{3,16}/
    key :bio,           String
    timestamps!

    # ORM:
    many :posts
    many :tags, :as => :taggable
    
    # Class methods:
    
    # Instance methods:
    def home
        return "#{self.name}/home"
    end

    def relevant_posts
        posts = Post.relevant_to(self)
        return posts
    end
    
    def err
        array = []
        self.errors.map { |k,v| array.push("#{k} #{v}") }
        return array
    end
           
end