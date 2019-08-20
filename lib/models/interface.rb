class Interface
  attr_accessor :prompt, :user

  def initialize
    @prompt = TTY::Prompt.new
  end

  def welcome
    puts "Wazzup"
    self.prompt.select("Brewer or Drinker?") do |menu|
      menu.choice "Brewer", -> {Interface.handle_brewer}
      menu.choice "Drinker", -> {Interface.handle_drinker}
    end
  end

  # Brewery User Path

  def self.handle_brewer
    self.prompt.select("Are you a new or returning user?") do |menu|
      menu.choice "New User", -> {Brewery.handle_new_brewer}
      menu.choice "Returning User", -> {Brewery.handle_returning_brewer}
    end
  end

  def main_brewery_menu
    system "clear"
    puts self.user.name
    prompt.select("Hello #{self.user.name}, What could you like to do today?") do |menu|
      menu.choice "See my popular beer", -> {Brewery.most_popular}
      menu.choice "See my collection", -> {Brewery.beers}
    end
  end

  # Consumer User Path

  def self.handle_drinker
    self.prompt.select("Are you a new or returning user?") do |menu|
      menu.choice "New User", -> {Consumer.handle_new_consumer}
      menu.choice "Returning User", -> {Consumer.handle_returning_consumer}
    end
  end

  def main_consumer_menu
    system "clear"
    puts self.user.name
    prompt.select("Hello #{self.user.name}, What could you like to do today?") do |menu|
      menu.choice "See my fridge", -> {Consumer.consumer_beers}
      menu.choice "Drink a beer", -> {Consumer.drink_a_beer}
    end
  end

end
