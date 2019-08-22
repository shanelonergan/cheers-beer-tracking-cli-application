class Interface
  attr_accessor :prompt, :consumer, :brewery

  def initialize
    @prompt = TTY::Prompt.new
  end

  def welcome
    system "clear"
    puts "Hi there!"
    self.prompt.select("Brewer or Drinker?") do |menu|
      menu.choice "Brewer", -> {self.handle_brewer}
      menu.choice "Drinker", -> {self.handle_drinker}
    end
  end

  # Brewery User Path

  def handle_brewer
    self.prompt.select("Are you a new or returning user?") do |menu|
      menu.choice "New User", -> {Brewery.handle_new_brewery}
      menu.choice "Returning User", -> {Brewery.handle_returning_brewery}
    end
  end

  def main_brewery_menu
    system "clear"
    puts self.brewery.name
    prompt.select("Hello #{self.brewery.name}, what would you like to do today?") do |menu|
      menu.choice "See my menu", -> {self.brewery.view_brewery_menu}
      menu.choice "Update my menu", -> {self.brewery.update_menu}
      menu.choice "See my stats", -> {self.brewery.view_brewery_stats}
      menu.choice "Industry stats", -> {Brewery.industry_stats}
      menu.choice "Delete my account", -> {self.brewery.delete_account}
      menu.choice "Exit", -> {self.exit_app}
    end
  end

  # Consumer User Path

  def handle_drinker
    self.prompt.select("Are you a new or returning user?") do |menu|
      menu.choice "New User", -> {Consumer.handle_new_consumer}
      menu.choice "Returning User", -> {Consumer.handle_returning_consumer}
    end
  end

  def main_consumer_menu
    system "clear"
    puts self.consumer.name
    prompt.select("Hello #{self.consumer.name}, what would you like to do today?") do |menu|
      menu.choice "See my Beer Profile", -> {self.consumer.beer_profile}
      menu.choice "Buy/drink some beer", -> {self.consumer.buy_drink_beer}
      menu.choice "See what others are drinking", -> {self.consumer.view_other_users}
      menu.choice "Explore breweries", -> {self.consumer.view_breweries}
      menu.choice "Delete Account", -> {self.consumer.delete_account}
      menu.choice "Exit", ->{self.exit_app}
    end
  end

  def exit_app
    puts ""
    puts "See you next time!"
    puts ""
    exit!
  end
end
