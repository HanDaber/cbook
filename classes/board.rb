class Board < CollegeBook
    
    key :name,  String, required: true
    key :bio,   String#, required: true
    
    many :posts
    
    # Class methods:
    def self.enabled tag
        found = false
        [
            "Spain@MIT", "Students for Israel", "Egyptian Club", "Parties",
            "Study Breaks", "Cultural", "Food", "Football", "Hockey", "Golf",
            "Squash", "Water Polo", "Sailing", "Soccer", "Basketball", "2.001",
            "2.003", "2.004", "2.005", "2.006", "2.007", "6.001", "6.002", "6.004",
            "6.006", "15.401", "15.501", "15.053", "15.354", "2012", "2013", "2014",
            "2015", "Buy", "Sell", "Services", "MacGreggor", "Burton Conner",
            "Chi Phi", "Number 6", "Westgate"
        ].each do |board_name|
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