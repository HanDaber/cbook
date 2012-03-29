class Tag < CollegeBook
    
    key :name, String, required: true
    
    belongs_to :taggable, :polymorphic => true
    # belongs_to :post
end