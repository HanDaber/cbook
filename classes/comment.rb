class Comment < CollegeBook
    
    key :text,      String, required: true
    
    belongs_to :post
    belongs_to :user, :as => :posted_by
end