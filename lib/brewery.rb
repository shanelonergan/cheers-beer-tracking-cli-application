class Brewery < ActiveRecord::Base
    has_many :beers

    def most_popular
        #returns the beer instance of the brewery's most bought beer
    end

    def least_popular
        #returns the beer instance of brewery's least bought beer
    end

    def highest_rated
        # returns the beer instance for the brewery's highest rated beer
    end

    def lowest_rated
        # returns the beer instance for the brewery's lowest rated beer
    end

    def self.largest_collection
        # returns the brewery instance with the largest number of beers
    end

end