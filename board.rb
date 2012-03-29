class Board < CollegeBook
    
    key :name,  String, required: true
    key :bio,   String, required: true
    
    many :posts
end