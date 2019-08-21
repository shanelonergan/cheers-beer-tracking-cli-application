class Brewery < ActiveRecord::Base
    has_many :beers
    has_many :consumer_beers, through: :beers

    #User Interface

    def self.handle_returning_brewery
        name = TTY::Prompt.new.select("Select your brewery:", Brewery.pluck(:name))
        Brewery.find_by(name: name)
    end

    def self.handle_new_brewery
        name = TTY::Prompt.new.ask("Welcome to our program! What is your brewery's name?")
        location = TTY::Prompt.new.ask("Where are you located?")
        year_founded = TTY::Prompt.new.ask("What year were you founded?")
        specialty = TTY::Prompt.new.select("What style do you specialize in?",
            ["Lager",
            "Pilsner",
            "IPA",
            "Sour",
            "Stout"])
        Brewery.create(name: name, location: location, year_founded: year_founded, specialty: specialty)
    end

    def delete_account
        confirm = TTY::Prompt.new.select("Are you sure you want to delete your account?", ["Yes", "No"])
        if confirm == "Yes"
            ConsumerBeer.all.each do |cbeer|
                cbeer.destroy if cbeer.beer.brewery_id == self.id
            end
            Beer.all.each do |beer|
                beer.destroy if beer.brewery_id == self.id
            end
            self.destroy
            puts "Sorry to see you go!"
        end
        exit!
    end

    # Data Methods
    
    def display_beers
        self.beers.each do |beer|
            puts "#{beer.name}: #{beer.style}, #{beer.abv}% ABV, Consumer Rating: #{beer.average_rating}/5"
        end
    end

    def view_brewery_menu
        puts "\n"
        puts "#{self.name}'s Beer Menu"
        puts "\n"
        self.display_beers
    end
    
    def most_popular
        #returns the beer instance of the brewery's most bought beer
        self.sold_beer_count.sort_by {|beer, num_bought| num_bought}.last
    end
    
    def sold_beer_count
        # returns the number of beers bought for each of the brewery's beer instances
        count_hash = {}
        beers.each do |beer|
            count_hash[beer] = (beer.consumer_beers.sum(:num_consumed) + beer.consumer_beers.sum(:num_available))
        end
        count_hash
    end
    
    def average_rating_by_beer
        # returns the average rating for each of the brewery's beer instances
        rating_hash = {}
        beers.each do |beer|
            rating_hash[beer] = beer.average_rating
        end
        rating_hash
    end

    def brewery_rating
        self.consumer_beers.average(:rating).to_f.floor(1)
    end

    def view_brewery_stats
        # most popular beer
        # average rating
        # beers sold
        self.print_brewery_rating
        self.print_most_popular
        self.print_beers_sold
    end

    def print_most_popular
        puts "\n"
        puts "Most Popular Beer:"
        puts "\n"
        puts "#{self.most_popular[0].name}"
    end
    
    def print_brewery_rating
        puts "\n"
        puts "#{self.name}'s Consumer Rating:"
        puts "\n"
        puts "#{self.brewery_rating}/5"
    end
    
    def print_beers_sold
        puts "\n"
        puts "Beer Sales:"
        puts "\n"
        self.sold_beer_count.each do |beer, num_sold|
            puts "#{beer.name}: #{num_sold} sold"
        end
    end
    
















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