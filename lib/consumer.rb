class Consumer < ActiveRecord::Base
    has_many :consumer_beers
    has_many :beers, through: :consumer_beers


    def view_fridge
        # display beers in a readable way with appropriate info
    end

    def beer_history
        # what stats do we want to include?
        # probably need several methods
    end

    def drink_beer_from_brewery(args)
        # creates new CustomerBeer instance with num_consumed = 1 and num_available = 0
    end

    def drink_beer_from_fridge(args)
        # finds CustomerBeer instance, increases num_consumed by 1, decreases num_available by 1
    end

    def buy_beer(args)
        # add to num_available if CustomerBeer instance exists or create new one
    end
    



end