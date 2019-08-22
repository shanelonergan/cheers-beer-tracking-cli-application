class Consumer < ActiveRecord::Base
    has_many :consumer_beers, dependent: :destroy
    has_many :beers, through: :consumer_beers

    # def figure_out_popular_beer
    #     self.consumer_beers
    # end

    def self.handle_returning_consumer
        puts "Welcome back! What is your name?"
        name = gets.chomp.capitalize
        if !Consumer.find_by(name: name)
          TTY::Prompt.new.keypress("User not found. Please enter a valid name. Press any key to try again.")
          nil
        else
          Consumer.find_by(name: name)
        end
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

    # Beer Profile

    def beer_profile
        TTY::Prompt.new.select("What do you want to see?") do |menu|
            menu.choice "My Fridge", -> {self.view_fridge}
            menu.choice "My Beer History", -> {self.beer_history_menu}
        end
    end

    def beer_history_menu
        # what stats do we want to include? Full history(list of beers consumed), stats(top 3 most drank beers, highest rated beers, breweries)
        # probably need several methods
        # this method will print out results of helper methods
        TTY::Prompt.new.select("What do you want to see?") do |menu|
            menu.choice "Quick Stats", -> {self.quick_stats}
            menu.choice "Full History", -> {self.full_beer_history}
        end
    end

    def fridge_contents
        beers_in_fridge = self.consumer_beers.select {|consumer_beer| consumer_beer.num_available > 0}
        beers_in_fridge.map { |consumer_beer| "#{consumer_beer.beer.name.pluralize}: #{consumer_beer.num_available}" }
    end

    def view_fridge
        # display beers in a readable way with appropriate info
        #self.consumer_beers.each { |consumer_beer| puts "#{consumer_beer.num_available} #{consumer_beer.beer.name.pluralize}" }
        puts "\n#{self.name}'s Fridge:"
        puts "\n#{fridge_contents.join("\n")}"

    end

    def beer_consumption
        beer_consumed = self.consumer_beers.sort_by { |beer| beer.num_consumed }.reverse
        beer_consumed.map {|consumer_beer| "#{consumer_beer.beer.name} from #{consumer_beer.brewery.name}: #{consumer_beer.num_consumed} drank"}
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
        frequency_hash.sort_by{ |brewery, count| count }.reverse
    end

    def print_brewery_frequency
        self.brewery_frequency.map {|brewery, count| "#{brewery.name}, beers consumed: #{count}"}
    end

    def quick_stats
        #top 3: most drank, highest rated, breweries
        puts "\nTop three most drank beers:\n#{beer_consumption[0..2].join("\n")}\n\nTop three highest rated beers:\n#{beer_ratings[0..2].join("\n")}\n\nTop three breweries:\n#{print_brewery_frequency[0..2].join("\n")}"
    end

    def full_beer_history
        puts "\n#{self.name}'s Beer History:"
        puts "\n#{beer_consumption.join("\n")}"
    end


    #Acquire Beer


    def buy_drink_beer
        TTY::Prompt.new.select("Buy or drink beer?") do |menu|
            menu.choice "Buy beer", -> {self.choose_beer_to_buy}
            menu.choice "Drink beer", -> {self.drink_beer_menu}
        end
    end

    def choose_beer_to_buy
        # add to num_available if ConsumerBeer instance exists or create new one
        brewery_choice = TTY::Prompt.new.select("What brewery?", Brewery.pluck(:name))
        beer_choice = TTY::Prompt.new.select("What beer?", Brewery.find_by(name: brewery_choice).beers.pluck(:name))
        beer = Beer.find_by(name: beer_choice)
        quantity = TTY::Prompt.new.ask("How many?").to_i
        buy_beer(beer, quantity)
    end

    def buy_beer(chosen_beer, chosen_quantity)
        #binding.pry
        if !self.consumer_beers.find_by(beer_id: chosen_beer.id)
            ConsumerBeer.create(beer_id: chosen_beer.id, consumer_id: self.id, num_available: chosen_quantity)
        else
            new_num = self.consumer_beers.find_by(beer_id: chosen_beer.id).num_available + chosen_quantity
            self.consumer_beers.find_by(beer_id: chosen_beer.id).update(num_available: new_num)
        end
    end

    def drink_beer_menu
        TTY::Prompt.new.select("Would you like to drink from your fridge or go to the brewery?") do |menu|
            menu.choice "Drink from fridge", -> {self.choose_beer_from_fridge}
            menu.choice "Go to brewery", -> {self.choose_beer_from_brewery}
        end
    end

    def choose_beer_from_brewery
        brewery_choice = TTY::Prompt.new.select("What brewery?", Brewery.pluck(:name))
        beer_choice = TTY::Prompt.new.select("What beer?", Brewery.find_by(name: brewery_choice).beers.pluck(:name))
        chosen_beer = Beer.find_by(name: beer_choice)
        drink_beer_from_brewery(chosen_beer)
    end

    def drink_beer_from_brewery(beer)
        # creates new ConsumerBeer instance with num_consumed = 1 and num_available = 0
        # or increases num_consumed by 1 for existing ConsumerBeer instance
        if !self.consumer_beers.find_by(beer_id: beer.id)
            rating = TTY::Prompt.new.ask("Rate this beer from 0-5") { |q| q.in('0-5') }
            ConsumerBeer.create(beer_id: beer.id, consumer_id: self.id, num_available: 0, num_consumed: 1, rating: rating)
        else
            current_cbeer = self.consumer_beers.find_by(beer_id: beer.id)
            if !current_cbeer.rating
                rating = TTY::Prompt.new.ask("Rate this beer from 0-5") { |q| q.in('0-5') }
            else
                update_rating = TTY::Prompt.new.select("Do you want to change your current rating of #{current_cbeer.rating}?", ["Yes", "No"])
                if update_rating == "Yes"
                    rating = TTY::Prompt.new.ask("Rate this beer from 0-5") { |q| q.in('0-5') }
                else
                    rating = current_cbeer.rating
                end
            end
            new_num = self.consumer_beers.find_by(beer_id: beer.id).num_consumed + 1
            self.consumer_beers.find_by(beer_id: beer.id).update(num_consumed: new_num, rating: rating)
        end

    end

    def choose_beer_from_fridge
        # provide list of beers in fridge
        beer_choice = TTY::Prompt.new.select("What beer?", fridge_contents)
        beer_name = beer_choice.split(": ")
        current_cbeer = Beer.find_by(name: beer_name[0].singularize)
        drink_beer_from_fridge(current_cbeer)
    end

    def drink_beer_from_fridge(beer)
        # finds ConsumerBeer instance, increases num_consumed by 1, decreases num_available by 1
        current_beer = self.consumer_beers.find_by(beer_id: beer.id)
        if !current_beer.rating
            rating = TTY::Prompt.new.ask("Rate this beer from 0-5") { |q| q.in('0-5') }
        else
            update_rating = TTY::Prompt.new.select("Do you want to change your current rating of #{current_beer.rating}?", ["Yes", "No"])
            if update_rating == "Yes"
                rating = TTY::Prompt.new.ask("Rate this beer from 0-5") { |q| q.in('0-5') }
            else
                rating = current_beer.rating
            end
        end
        new_num_available = current_beer.num_available - 1
        new_num_consumed = current_beer.num_consumed + 1
        current_beer.update(num_available: new_num_available, num_consumed: new_num_consumed, rating: rating)
        puts "🍻 Cheers! You now have #{current_beer.num_available} #{beer.name}s left 🍻"
    end

    # see other users info

    def view_other_users
        other_user_name = TTY::Prompt.new.select("Which fellow drinker would you like to see more about?", Consumer.where.not(name: self.name).pluck(:name))
        other_user = Consumer.find_by(name: other_user_name)
        TTY::Prompt.new.select("What would you like to see about #{other_user_name}?") do |menu|
            menu.choice "View #{other_user_name}'s fridge", -> {other_user.view_fridge}
            menu.choice "View #{other_user_name}'s quick stats", -> {other_user.quick_stats}
        end
    end

    # view brewery info

    def view_breweries
        brewery_choice = TTY::Prompt.new.select("What brewery?", Brewery.pluck(:name))
        brewery = Brewery.find_by(name: brewery_choice)
        TTY::Prompt.new.select("What information would you like to see about #{brewery_choice}?") do |menu|
            menu.choice "View Menu", -> {self.view_brewery_menu(brewery)}
            menu.choice "View Stats", -> {self.view_brewery_stats(brewery)}
        end
    end

    def view_brewery_menu(brewery)
        puts "\n"
        puts "#{brewery.name}'s Beer Menu"
        puts "\n"
        brewery.display_beers
    end
    # brewery.average_rating_by_beer.each do |beer, rating|
    #     puts "#{beer.name}: #{num_sold} sold"
    # end
    # puts "#{brewery.average_rating_by_beer}: "

    def view_brewery_stats(brewery)
        # most popular beer
        # average rating
        # beers sold
        self.print_brewery_rating(brewery)
        self.print_most_popular(brewery)
        self.print_beers_sold(brewery)
    end

    def print_most_popular(brewery)
        puts "\n"
        puts "Most Popular Beer:"
        puts "\n"
        puts "#{brewery.most_popular[0].name}"
    end

    def print_brewery_rating(brewery)
        puts "\n"
        puts "#{brewery.name}'s Consumer Rating:"
        puts "\n"
        puts "#{brewery.brewery_rating}/5"
    end

    def print_beers_sold(brewery)
        puts "\n"
        puts "Beer Sales:"
        puts "\n"
        brewery.sold_beer_count.each do |beer, num_sold|
            puts "#{beer.name}: #{num_sold} sold"
        end
    end

    # delete account

    def delete_account
        confirm = TTY::Prompt.new.select("Are you sure you want to delete your account?", ["Yes", "No"])
        if confirm == "Yes"
            # ConsumerBeer.all.each do |cbeer|
            #     cbeer.destroy if cbeer.consumer_id == self.id
            # end
            self.destroy
            puts "Sorry to see you go!"
        end
        exit!
    end

end
