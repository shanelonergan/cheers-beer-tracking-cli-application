class Beer < ActiveRecord::Base
    belongs_to :brewery
    has_many :consumer_beers, dependent: :destroy
    has_many :consumers, through: :consumer_beers


    def average_rating
        #returns the average rating of all consumer_beer instances of this beer
        if self.consumer_beers == []
            return "Not Rated"
        else
            self.consumer_beers.average(:rating).to_f.floor(2)
        end
    end

    def self.highest_rated_beer
        beers_with_ratings = Beer.all.select {|beer| beer.average_rating.class == Float}
        beers_with_ratings.sort_by {|beer| beer.average_rating}.last
    end

    def self.most_popular
        #returns beer that has the most user_beers instances
        Beer.all.sort_by { |beer| beer.consumer_beers.count }.last
    end

    def num_sold
        num_consumed = self.consumer_beers.sum(:num_consumed)
        num_available = self.consumer_beers.sum(:num_available)
        num_consumed + num_available
    end

    def self.best_seller
        Beer.all.sort_by { |beer| beer.num_sold }.last
    end

end
