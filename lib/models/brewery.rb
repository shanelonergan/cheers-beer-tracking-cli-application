class Brewery < ActiveRecord::Base
    has_many :beers
    has_many :consumer_beers, through: :beers


    def display_beers
        self.beers.each do |beer|
            puts "#{beer.name}: #{beer.style}, #{beer.abv}% ABV"
        end
    end

















    # def sold_beer_count
    #     # returns the number of beers bought for each of the brewery's beer instances
    #     count_hash = {}
    #     beers.each do |beer|
    #         count_hash[beer] = (beer.consumer_beers.sum(:num_consumed) + beer.consumer_beers.sum(:num_available))
    #     end
    #     count_hash
    # end

    # # def average_rating_by_beer
    # #     # returns the average rating for each of the brewery's beer instances
    # #     rating_hash = {}
    # #     beers.each do |beer|
    # #         rating_hash[beer] = beer.average_rating
    # #     end
    # #     rating_hash
    # # end

    # def most_popular
    #     #returns the beer instance of the brewery's most bought beer
    #     self.sold_beer_count.sort_by {|beer, num_bought| num_bought}.last
    # end

    # def least_popular
    #     #returns the beer instance of brewery's least bought beer
    #     self.sold_beer_count.sort_by {|beer, num_bought| num_bought}.first
    # end

    # def highest_rated
    #     # returns the beer instance for the brewery's highest rated beer
    # end

    # def lowest_rated
    #     # returns the beer instance for the brewery's lowest rated beer
    # end

    # def self.largest_collection
    #     # returns the brewery instance with the largest number of beers
    #     Brewery.all.sort_by {|brewery| brewery.beers.count}.last
    # end



    def num_beers_sold
    #     # returns the number of beers bought for each of the brewery's beer instances
    #     # update below to rely on methods from Beer class
    #     count_hash = {}
    #     beers.each do |beer|
    #         count_hash[beer] = (beer.consumer_beers.sum(:num_consumed) + beer.consumer_beers.sum(:num_available))
    #     end
    #     count_hash
    end

    def average_beer_ratings
    #     # returns the average rating for each of the brewery's beer instances
    #     # update below to rely on methods from Beer class
    #     rating_hash = {}
    #     beers.each do |beer|
    #         rating_hash[beer] = beer.average_rating
    #     end
    #     rating_hash
    end

    def consumer_average_age
        # returns the average age of this brewery's consumers
    end

    def consumer_gender
        # returns the gender breakdown of this brewery's consumers
    end

    def consumer_locations
        # returns the location breakdown of this brewery's consumers
    end

    



end