require_relative '../config/environment'

cli = Interface.new
user_object = cli.welcome

while !user_object
  user_object = cli.welcome
end

cli.consumer = user_object

choice = cli.main_consumer_menu

binding.pry
puts "HELLO WORLD"
