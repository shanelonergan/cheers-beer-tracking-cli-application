class Consumer < ActiveRecord::Base
    has_many :consumer_beers
    has_many :beers, through: :consumer_beers

    def self.handle_returning_consumer
        puts "Welcome back! What is your name?"
        name = gets.chomp
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
    end

    def beer_history
        # what stats do we want to include?
        # probably need several methods
        # this method will print out results of helper methods
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