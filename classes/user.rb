class User# < CollegeBook
    
    # Import the MongoMapper::Document Class (inherited by all subclasses)
    include MongoMapper::Document
    safe

    # Database model:
    key :name,          String,     required: true, unique: true
    key :email,         String,     required: true, unique: true, format: /^[A-Z0-9._]+@mit\.edu$/i
    key :pass,          String,     required: true,               format: /[A-Za-z0-9_\.]{3,16}/
    key :bio,           String
    key :user_comments, Array
    timestamps!

    # ORM:
    many :posts
    many :tags
    many :comments, :in => :user_comments#, :as => :commentable
    
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
        my_tags = self.tags
        
        # If tag_array is a string, make it an array
        unless tag_array.respond_to? 'each'
            tmp = [tag_array]
            tag_array = tmp
        end
        
        tag_array.each do |tag|
            exists_flag = false
            
            my_tags.each do |mytag|
                if tag[0] == mytag.name
                    exists_flag = true
                end
            end
            
            unless exists_flag
                new_tag = self.tags.create({name: tag[0]})
                
                if new_tag.save
                    saved_array << new_tag
                end
            end
        end
        
        if saved_array.length < 1
            return false
        else
            return saved_array
        end
    end
           
end