class Board < CollegeBook
    
    key :name,  String, required: true
    key :bio,   String, required: true
    
    many :posts
    
    # Instance methods:
    def tagged_posts
        posts = Post.tagged_as self.name
        return posts
    end
end