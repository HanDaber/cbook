class Board
    
    # Import the MongoMapper::Document Class
    include MongoMapper::Document
    safe

    key :name,  String, required: true
    key :bio,   String#, required: true

    many :posts
    
    # Class methods:
    def self.enabled board_name
        found = false
        Tag.all.each do |tag|
            if board_name == tag
                found = true
            end
        end
        return found
    end
    
    # Instance methods:
    def tagged_posts
        posts = Post.tagged_as self.name
        return posts
    end
end