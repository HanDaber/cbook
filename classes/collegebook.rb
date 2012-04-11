class CollegeBook

    # Import the MongoMapper::Document Class (inherited by all subclasses)
    include MongoMapper::Document
    safe

    helpers do
        include Rack::Utils
        alias_method :h, :escape_html
    end
    
    def self.net
    	net_items = {
    	    'market' => [
    			'Buy',
    			'Sell',
    			'Services'
    		],
    		'housing' => [
    			'MacGreggor',
    			'Burton Conner',
    			'Chi Phi',
    			'Number 6',
    			'Westgate'
    		],
    		'social' => [
    			'clubs' => [
					'Spain@MIT',
					'Students for Israel',
					'Egyptian Club'
    			],
    			'events' => [
                    'Parties',
    				'Study Breaks',
    				'Cultural',
    				'Food'
    			]
    		],
    		'sports' => [
    			'varsity' => [
					'Football',
					'Hockey',
					'Golf'
    			],
    			'pickup' => [
					'Squash',
					'Water Polo',
					'Sailing',
					'Soccer'
    			],
    			'im' => [
					'Hockey',
					'Squash',
					'Soccer',
					'Basketball'
    			]
    		],
    		'academic' => [
    		    'classes' => [
					'2012',
					'2013',
					'2014',
					'2015'
    			],
    			'courses' => [
					'2s' => [
						"2.001",
						"2.003",
						"2.004",
						"2.005",
						"2.006",
						"2.007"
					],
					'6s' => [
						"6.001",
						"6.002",
						"6.004",
						"6.006"
					],
					'15s' => [
						"15.401",
						"15.501",
						"15.053",
						"15.354"
					]
    			]
    		]
    	}
    	return net_items
    end
end