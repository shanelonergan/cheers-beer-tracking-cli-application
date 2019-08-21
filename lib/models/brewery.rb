class Brewery < ActiveRecord::Base
    has_many :beers, dependent: :destroy
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
            # ConsumerBeer.all.each do |cbeer|
            #     cbeer.destroy if cbeer.beer.brewery_id == self.id
            # end
            # Beer.all.each do |beer|
            #     beer.destroy if beer.brewery_id == self.id
            # end
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

    def total_beers_sold
        self.sold_beer_count.values.sum
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
    
    def update_menu
        TTY::Prompt.new.select("What would you like to change?") do |menu|
            menu.choice "Add a beer", -> {self.add_beer}
            menu.choice "Remove a beer", -> {self.choose_remove_beer}
        end
    end

    def add_beer
        name = TTY::Prompt.new.ask("What is your new beer's name?")
        style = TTY::Prompt.new.ask("What style is this beer?")
        abv = TTY::Prompt.new.ask("What is the ABV content?")
        Beer.create(name: name, style: style, abv: abv, brewery: self)
        
    end

    def choose_remove_beer
        beer_choice = TTY::Prompt.new.select("What beer do you want to remove?", self.beers.pluck(:name))
        chosen_beer = Beer.find_by(name: beer_choice)
        remove_beer(chosen_beer)
    end

    def remove_beer(chosen_beer)
        confirm = TTY::Prompt.new.select("Are you sure?", ["Yes", "No"])
        if confirm == "Yes"
            # ConsumerBeer.all.each do |cbeer|
            #     cbeer.destroy if cbeer.beer_id == chosen_beer.id
            # end
            chosen_beer.destroy
        end
    end

    def self.industry_stats
        #3 highest rated breweries
        Brewery.print_highest_rated
        #3 most selling brewery
        Brewery.print_most_sold
        #top selling beer
        Brewery.print_top_selling_beer
        #highest rated beer
        Brewery.print_highest_rated_beer
        #most produced style
        Brewery.print_most_produced_style
    end
    
    def self.print_highest_rated
        puts "\nThe 3 highest rated breweries:\n\n#{Brewery.highest_rated[0..2].join("\n")}"
    end

    def self.highest_rated
        brewery_with_rating = Brewery.all.select {|brewery| brewery.brewery_rating != 0}
        sorted_brewery_rating = brewery_with_rating.sort_by { |brewery| brewery.brewery_rating }.reverse
        sorted_brewery_rating.map {|brewery| "#{brewery.name}: #{brewery.brewery_rating}"}
    end

    def self.print_most_sold
        puts "\nThe 3 highest selling breweries:\n\n#{Brewery.beers_sold_by_brewery[0..2].join("\n")}"
    end

    def self.beers_sold_by_brewery
        sorted_beers_sold = Brewery.all.sort_by {|brewery| brewery.total_beers_sold}.reverse
        sorted_beers_sold.map {|brewery| "#{brewery.name}: #{brewery.total_beers_sold}"}
    end

    def self.print_top_selling_beer
        highest_selling_beer = Beer.best_seller
        puts "\nThe top selling beer:\n\n#{highest_selling_beer.name} from #{highest_selling_beer.brewery.name} with #{highest_selling_beer.num_sold} sold"
    end

    def self.print_highest_rated_beer
        top_rated_beer = Beer.highest_rated_beer
        puts "\nThe highest rated beer:\n\n#{top_rated_beer.name} from #{top_rated_beer.brewery.name} with an average rating of #{top_rated_beer.average_rating}/5"
    end

    def self.print_most_produced_style
        puts "\nThe most produced beer style:\n\n#{Brewery.most_produced_style[0]} with #{Brewery.most_produced_style[1]} beers"
    end

    def self.most_produced_style
        style_hash = Beer.all.reduce(Hash.new(0)) do |memo, beer|
            memo[beer.style] += 1
            memo
        end
        style_hash.sort_by {|style, count| count}.last
    end

end