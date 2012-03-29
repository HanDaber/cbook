class User < CollegeBook
    attr_accessor :name
    
    def initialize
        @name = nil
    end
    
    key :name,          String,     required: true, unique: true
    key :email,         String,     required: true, unique: true#, format: /^[A-Z0-9._]+@mit\.edu$/i
    key :pass,          String,     required: true
    key :bio,           String
    # key :passwd_digest, String,     required: true
    timestamps!

    many :posts
    many :tags, :as => :taggable

    def exists
        user_exists = User.where(name: self.name, pass: self.pass)
        if user_exists
            return true
        else
            return false
        end
    end

    def build_session
        return {
            name: self.name,
            email: self.email,
            pass: self.pass,
            since: self.created_at
        }
        # session[:name] = self.name
        # session[:email] = self.email
        # # Totally not secure, sending password in plaintext:
        # session[:pass] = self.pass
        # session[:since] = self.created_at
    end
    
    def home
        return "#{self.name}/home"
    end
           
end