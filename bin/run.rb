require_relative '../config/environment'

cli = Interface.new
user_object = cli.welcome

while !user_object
  user_object = cli.welcome
end

if user_object.class == Consumer
  cli.consumer = user_object
  cli.main_consumer_menu
else 
  cli.brewery = user_object
  cli.main_brewery_menu
end

loop do
  TTY::Prompt.new.keypress("\nPress any key to return to the main menu")
  user_object.reload
  if user_object.class == Consumer
    cli.main_consumer_menu
  else 
    cli.main_brewery_menu
  end
end

binding.pry
puts "HELLO WORLD"
