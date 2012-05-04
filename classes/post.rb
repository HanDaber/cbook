class Post < Web
    
    # Import the MongoMapper::Document Class
    include MongoMapper::Document
    safe
    
    # Database model:
    key :text,      String, required: true
    # key :post_tags, Array
    # key :post_comments, Array
    timestamps!
    
    # ORM:
    belongs_to :user
    many :tags, :as => :taggable
    many :comments#, :in => :post_comments
    
    # Class methods:
    def self.relevant_to user
        tags = user.tags
        posts_array = []
        
        # This is horribly inefficient:
        all_posts = Post.all
        
        all_posts.each do |post|
            show_post = false

            tags.each do |tag|
                post.post_tags.each do |t|
                    show_post = true if t[1] == tag.name && post.user != user
                end
            end

            if show_post
                posts_array << post
            end
        end
        return posts_array
    end
    
    def self.tagged_as tag
        posts_array = []
        
        all_posts = Post.all

        all_posts.each do |post|
            show_post = false
            
            post.post_tags.each do |t|
                show_post = true if t[1] == tag
            end

            if show_post
                posts_array << post
            end
        end
        return posts_array
    end
    
    def self.find_by_object_id id
        return self.find( { _id: BSON::ObjectId( id )} )
    end
    
    # Instance methods:
    
end
