class Beer < ActiveRecord::Base
    belongs_to :brewery
    has_many :consumer_beers
    has_many :consumers, through: :consumer_beers

    def

    def average_rating
        #returns the average rating of all consumer_beer instances of this beer
        consumer_beers_with_ratings = self.consumer_beers.select(rating: true)
        average_rating = consumer_beers_with_ratings.average(:rating)
        #make it legible
        average_rating.to_f.floor(2) 
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
