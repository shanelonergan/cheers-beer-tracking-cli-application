
Consumer.destroy_all
Brewery.destroy_all
Beer.destroy_all
ConsumerBeer.destroy_all


matt = Consumer.create(name: "Matt", age: 27, location: "Michigan", gender: "Male", favorite_style: "Belgian White")
josh = Consumer.create(name: "Josh", age: 30, location: "Texas", gender: "Male", favorite_style: "Sour")
shane = Consumer.create(name: "Shane", age: 23, location: "Michigan", gender: "Male", favorite_style: "New England IPA")
# kenny = Consumer.create("Kenny", 41, "New York", "Male", "Stout")
# derya = Consumer.create("Derya", 21, "Illinois", "Female", "Sour")
# joel = Consumer.create("Joel", 34, "California", "Male", "Pale Ale")
# kimberly = Consumer.create("Kimberly", 42, "Wisconsin", "Female", "Pilsner")
# renee = Consumer.create("Renee", 54, "New York", "Female", "Pilsner")
# michelle = Consumer.create("Michelle", 67, "Massachusetts", "Female", "Pale Ale")
# brian = Consumer.create("Brian", 83, "Florida", "Male", "Porter")
# mina = Consumer.create("Zermina", 50, "California", "Female", "Sour")
# tate = Consumer.create("Tate", 66, "Texas", "Male", "Pilsner")
# sukrit = Consumer.create("Sukrit", 25, "California", "Male", "Lager")
# avi = Consumer.create("Avi", 30, "Colorado", "Male", "Pale Ale")
# brandon = Consumer.create("Brandon", 45, "Arkansas", "Male", "Pale Ale")
# eric = Consumer.create("Eric", 37, "Nevada", "Male", "Stout")
# dan = Consumer.create("Dan", 53, "Oregon", "Male", "Wheat")

yuengling = Brewery.create(name: "D. G. Yuengling & Son Inc.", location: "Pennsylvania", specialty: "Lager", year_founded: 1829)
boston_beer = Brewery.create(name: "Boston Beer Co.", location: "Massachusetts", specialty: "Lager", year_founded: 1984)
sierra_nevada = Brewery.create(name: "Sierra Nevada Brewing Co.", location: "California", specialty: "Pale Ale", year_founded: 1979)
new_belgium = Brewery.create(name: "New Belgium Brewing Co.", location: "Colorado", specialty: "Belgian White", year_founded: 1988)
bells = Brewery.create(name: "Bell's Brewery Inc.", location: "Michigan", specialty: "Wheat", year_founded: 1983)
brooklyn = Brewery.create(name: "Brooklyn Brewery", location: "New York", specialty: "Lager", year_founded: 1987)

yuengling_golden = Beer.create(brewery_id: yuengling.id, name: "Yuengling Golden Pilsner", style: "Pilsner", additions: "", abv: 4.7)
yuengling_lager = Beer.create(brewery_id: yuengling.id, name: "Yuengling Traditional Lager", style: "Lager", additions: "", abv: 4.5)
sam_adams = Beer.create(brewery_id: boston_beer.id, name: "Samuel Adams Boston Lager", style: "Lager", additions: "", abv: 5.0)
angry_orchard = Beer.create(brewery_id: boston_beer.id, name: "Angry Orchard Hard Cider", style: "Cider", additions: "", abv: 5.0)
sierra_nevada_pale = Beer.create(brewery_id: sierra_nevada.id, name: "Sierra Nevada Pale Ale", style: "Pale Ale", additions: "", abv: 5.6)
narwhal = Beer.create(brewery_id: sierra_nevada.id, name: "Narwhal", style: "Stout", additions: "", abv: 10.2)
fat_tire = Beer.create(brewery_id: new_belgium.id, name: "Fat Tire Belgian White", style: "Belgian White", additions: "", abv: 5.2)
voodoo_ranger = Beer.create(brewery_id: new_belgium.id, name: "Voodoo Ranger IPA", style: "IPA", additions: "", abv: 7.0)
oberon = Beer.create(brewery_id: bells.id, name: "Oberon", style: "Wheat", additions: "", abv: 5.8)
two_hearted = Beer.create(brewery_id: bells.id, name: "Two Hearted Ale", style: "IPA", additions: "", abv: 7)
defender = Beer.create(brewery_id: brooklyn.id, name: "Defender IPA", style: "API", additions: "", abv: 5.5)
brooklyn_lager = Beer.create(brewery_id: brooklyn.id, name: "Brooklyn Lager", style: "Lager", additions: "", abv: 5.2)

mb1 = ConsumerBeer.create(beer_id: oberon.id, consumer_id: matt.id, num_available: 6, size: 12, packaging: "bottle", exp_date: Date.new(2019,9,19), rating: 5)
mb2 = ConsumerBeer.create(beer_id: yuengling_golden.id, consumer_id: matt.id, num_available: 1, size: 12, packaging: "bottle", exp_date: Date.new(2019,10,8))
sb1 = ConsumerBeer.create(beer_id: defender.id, consumer_id: shane.id, num_available: 6, size: 12, packaging: "bottle", exp_date: Date.new(2019,9,30))
sb2 = ConsumerBeer.create(beer_id: oberon.id, consumer_id: matt.id, num_available: 6, size: 12, packaging: "bottle", exp_date: Date.new(2019,9,19), rating: 2)


puts "gettin' drunk"
