class Tag < Web
    
    # Import the MongoMapper::Document Class
    include MongoMapper::Document
    safe
    
    key :name, String, required: true
    
    belongs_to :taggable, :polymorphic => true
    
    def self.all 
        return [
            "Spain@MIT", "Students for Israel", "Egyptian Club", "Parties",
            "Study Breaks", "Cultural", "Food", "Football", "Hockey", "Golf",
            "Squash", "Water Polo", "Sailing", "Soccer", "Basketball", "2.001",
            "2.003", "2.004", "2.005", "2.006", "2.007", "6.001", "6.002", "6.004",
            "6.006", "15.401", "15.501", "15.053", "15.354", "2012", "2013", "2014",
            "2015", "Buy", "Sell", "Services", "MacGreggor", "Burton Conner",
            "Chi Phi", "Number 6", "Westgate"
        ]
    end

end