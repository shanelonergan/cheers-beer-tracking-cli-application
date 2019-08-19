class Brewery < ActiveRecord::Base
    has_many :beers

    def sold_beer_count
        # returns the number of beers bought for each of the brewery's beer instances
        count_hash = {}
        beers.each do |beer|
            count_hash[beer] = (ConsumerBeer.all.where(beer_id: beer.id).sum(:num_consumed) + ConsumerBeer.all.where(beer_id: beer.id).sum(:num_available))
        end
        count_hash
    end

    def most_popular
        #returns the beer instance of the brewery's most bought beer
        # self.bought_beer_count.sort_by {|beer, num_bought| num_bought}.last
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