class Beer < ActiveRecord::Base
    belongs_to :brewery
    has_many :consumer_beers
    has_many :consumers, through: :consumer_beers

    def average_rating
        #returns the average rating of all user_beer instances of this beer
    end
    
    def self.most_popular
        #returns the instance of the most bought beer
    end

    def self.least_popular
        #returns the instance of the least bought beer
    end

    def self.highest_rated
        #returns the instance of the highest rated beer
    end

    def self.lowest_rated
        #returns the instance of the lowest rated beer
    end


end