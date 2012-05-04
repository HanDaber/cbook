class Comment < Web
    
    include MongoMapper::EmbeddedDocument
    
    key :text,      String, required: true
    timestamps!
    
    belongs_to :post
    # belongs_to :user, :as => :posted_by
end