class User < CollegeBook

    # Database model:
    key :name,          String,     required: true, unique: true
    key :email,         String,     required: true, unique: true, format: /^[A-Z0-9._]+@mit\.edu$/i
    key :pass,          String,     required: true,               format: /[A-Za-z0-9_]{3,16}/
    key :bio,           String
    key :tags,          Array,                      unique: true
    timestamps!

    # ORM:
    many :posts
    many :tags, :in => :tags#, :as => :taggable
    
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
        err_array = []
        
        self.errors.map do |k,v| 
            err_array.push("#{k} #{v}")
        end
        return err_array
    end
    
    def add_tags tag_array
        saved_array = []
        unless tag_array.respond_to? 'each'
            tag_array = [tag_array]
        end
        tag_array.each do |tag|
            if tag exists
                don't do shit'
            else
                save it
            end
            # have_tag = self.
            # build_tag = Tag.find_or_create_by_name(tag[0])
            new_tag = self.tags.create({name: tag})
            if new_tag.save(safe: true)
                saved_array << new_tag
            end
        end
        if saved_array.length < 1
            return false
        else
            return saved_array
        end
    end
           
end