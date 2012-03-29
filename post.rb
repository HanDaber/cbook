class Post < CollegeBook
    
    key :text,      String, required: true
    key :post_tags, Array
    timestamps!
    
    belongs_to :user
    many :tags, :in => :post_tags, :as => :taggable
end
