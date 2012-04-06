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
    
    def err
        arr = []
        self.errors.map { |k,v| arr.push("#{k} #{v}") }
        return arr
    end
           
end