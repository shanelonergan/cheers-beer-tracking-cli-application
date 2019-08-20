class Consumer < ActiveRecord::Base
    has_many :consumer_beers
    has_many :beers, through: :consumer_beers

    def figure_out_popular_beer
        self.consumer_beers
    end

    def self.handle_returning_consumer
        puts "Welcome back! What is your name?"
        name = gets.chomp.capitalize
        Consumer.find_by(name: name)
    end

    def self.handle_new_consumer
        name = TTY::Prompt.new.ask("Welcome to our program! What is your name?")
        age = TTY::Prompt.new.ask("What is your age?")
        location = TTY::Prompt.new.ask("Where do you live?")
        gender = TTY::Prompt.new.select("What is your gender?", ["Male", "Female"])
        favorite_style = TTY::Prompt.new.select("What is your favorite style of beer?",
            ["Lager",
            "Pilsner",
            "IPA",
            "Sour",
            "Stout"])
        Consumer.create(name: name, age: age, location: location, gender: gender, favorite_style: favorite_style)
    end

    def view_fridge
        # display beers in a readable way with appropriate info
        self.consumer_beers.each { |consumer_beer| puts "#{consumer_beer.num_available} #{consumer_beer.beer.name.pluralize}" }
    end

    def beer_consumption
        beer_consumed = self.consumer_beers.sort_by { |beer| beer.num_consumed }.reverse
        beer_consumed.map {|consumer_beer| "#{consumer_beer.beer.name}: #{consumer_beer.num_consumed}"}
    end

    def beer_ratings
        beers_with_rating = self.consumer_beers.where.not(rating: nil)
        beer_rating = beers_with_rating.sort_by { |beer| beer.rating }.reverse
        beer_rating.map {|consumer_beer| "#{consumer_beer.beer.name}: #{consumer_beer.rating}"}
    end

    def brewery_consumed_count
        self.consumer_beers.map {|consumer_beer| {consumer_beer.brewery => consumer_beer.num_consumed}}
    end

    def brewery_frequency
        frequency_hash = Hash.new(0)
        brewery_consumed_count.each do |brew_hash|
            frequency_hash[brew_hash.keys.first] += brew_hash.values.first
        end
        frequency_hash
    end

    def print_brewery_frequency
        self.brewery_frequency.map {|brewery, count| "#{brewery.name}, beers consumed: #{count}"}
    end

    def quick_stats
        #top 3: most drank, highest rated, breweries
        puts "Your top three most drank beers: #{beer_consumption[0..2].join(", ")}"
        puts "Your top three highest rated beers: #{beer_ratings[0..2].join(", ")}"
        puts "Your top three breweries: #{print_brewery_frequency[0..2].join(", ")}"
    end

    def beer_history_menu
        # what stats do we want to include? Full history(list of beers consumed), stats(top 3 most drank beers, highest rated beers, breweries)
        # probably need several methods
        # this method will print out results of helper methods
        TTY::Prompt.new.select("What do you want to see?") do |menu|
            menu.choice "Quick Stats", -> {self.quick_stats}
            menu.choice "Full History", -> {self.beer_history}
        end
    end

    def beer_profile
        TTY::Prompt.new.select("What do you want to see?") do |menu|
            menu.choice "My Fridge", -> {self.view_fridge}
            menu.choice "My Beer History", -> {self.beer_history_menu}
        end
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