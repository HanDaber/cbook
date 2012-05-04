class Tag# < CollegeBook
    
    # Import the MongoMapper::Document Class (inherited by all subclasses)
    include MongoMapper::EmbeddedDocument
    safe
    
    key :name, String, required: true
    
    # belongs_to :taggable, :polymorphic => true

end