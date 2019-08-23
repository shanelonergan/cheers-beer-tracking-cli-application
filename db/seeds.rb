
Consumer.destroy_all
Brewery.destroy_all
Beer.destroy_all
ConsumerBeer.destroy_all

# Consumers

matt = Consumer.create(name: "Matt", age: 27, location: "Michigan", gender: "Male", favorite_style: "Belgian White")
josh = Consumer.create(name: "Josh", age: 30, location: "Texas", gender: "Male", favorite_style: "Sour")
shane = Consumer.create(name: "Shane", age: 23, location: "Michigan", gender: "Male", favorite_style: "IPA")
sukrit = Consumer.create(name: "Sukrit", age: 90, location: "New York", gender: "Male", favorite_style: "Pilsner")


# Breweries

brooklyn = Brewery.create(name: "Brooklyn Brewery", location: "New York", specialty: "Lager", year_founded: 1987)
finback = Brewery.create(name: "Finback Brewery", location: "New York", specialty: "Sour", year_founded: 2011)
five_boroughs = Brewery.create(name: "Five Boroughs Brewing Co.", location: "New York", specialty: "IPA", year_founded: 2015)
kcbc = Brewery.create(name: "King's County Brewers Collective", location: "New York", specialty: "IPA", year_founded: 2016)
threes = Brewery.create(name: "Threes Brewing", location: "New York", specialty: "Lager", year_founded: 2014)

# Beers

bk_defender = Beer.create(brewery_id: brooklyn.id, name: "Defender IPA", style: "IPA", additions: "", abv: 5.5)
bk_lager = Beer.create(brewery_id: brooklyn.id, name: "Brooklyn Lager", style: "Lager", additions: "", abv: 5.2)
bk_sour = Beer.create(brewery_id: brooklyn.id, name: "Brooklyn Bel Air Sour", style: "Sour", additions: "", abv: 5.8)
finback_ipa = Beer.create(brewery_id: finback.id, name: "Finback IPA", style: "IPA", additions: "", abv: 7.2)
finback_starchild = Beer.create(brewery_id: finback.id, name: "Starchild", style: "Sour", additions: "grapefruit peel", abv: 4.6)
finback_universe = Beer.create(brewery_id: finback.id, name: "I Feel The Universe", style: "Gose", additions: "passion fruit", abv: 11)
fb_lager = Beer.create(brewery_id: five_boroughs.id, name: "Hoppy Lager", style: "Lager", additions: "", abv: 6.8)
fb_pilsner = Beer.create(brewery_id: five_boroughs.id, name: "Pilsner", style: "Pilsner", additions: "", abv: 5)
fb_juicy = Beer.create(brewery_id: five_boroughs.id, name: "Tiny Juicy IPA", style: "IPA", additions: "", abv: 4.2)
robot_fish = Beer.create(brewery_id: kcbc.id, name: "Robot Fish", style: "IPA", additions: "", abv: 5)
fairy = Beer.create(brewery_id: kcbc.id, name: "Lemon Berry Cherry Fairy", style: "Gose", additions: "lemon, strawberry, blackberry, and cherry", abv: 4.5)
burritonado = Beer.create(brewery_id: kcbc.id, name: "Burritonado", style: "IPA", additions: "apricot, strawberry, and lime", abv: 6.9)
conclusion = Beer.create(brewery_id: threes.id, name: "Logical Conclusion", style: "IPA", additions: "", abv: 7)
no_more = Beer.create(brewery_id: threes.id, name: "Everything Was Forever Until It Was No More", style: "Stout", additions: "", abv: 8.5)
vliet = Beer.create(brewery_id: threes.id, name: "Vliet", style: "Pilsner", additions: "", abv: 5.2)


# ConsumerBeers

mb1 = ConsumerBeer.create(beer_id: bk_defender.id, consumer_id: matt.id, num_available: 6, num_consumed: 18, size: 12, packaging: "bottle", rating: 3)
mb2 = ConsumerBeer.create(beer_id: bk_lager.id, consumer_id: matt.id, num_available: 1, num_consumed: 5, size: 12, packaging: "bottle", rating: 4)
mb3 = ConsumerBeer.create(beer_id: bk_sour.id, consumer_id: matt.id, num_available: 3, num_consumed: 9, size: 12, packaging: "bottle", rating: 3.5)
mb4 = ConsumerBeer.create(beer_id: finback_universe.id, consumer_id: matt.id, num_available: 3, num_consumed: 1, size: 12, packaging: "can", rating: 4.5)
mb5 = ConsumerBeer.create(beer_id: fb_juicy.id, consumer_id: matt.id, num_available: 8, num_consumed: 0, size: 12, packaging: "can")

sb1 = ConsumerBeer.create(beer_id: conclusion.id, consumer_id: shane.id, num_available: 4, num_consumed: 12, size: 12, packaging: "can", rating: 4.5)
sb2 = ConsumerBeer.create(beer_id: robot_fish.id, consumer_id: shane.id, num_available: 1, num_consumed: 36, size: 12, packaging: "can", rating: 5)
sb3 = ConsumerBeer.create(beer_id: fairy.id, consumer_id: shane.id, num_available: 2, num_consumed: 2, size: 12, packaging: "can", rating: 5)
sb4 = ConsumerBeer.create(beer_id: burritonado.id, consumer_id: shane.id, num_available: 1, num_consumed: 3, size: 12, packaging: "can", rating: 4)
sb5 = ConsumerBeer.create(beer_id: fb_juicy.id, consumer_id: shane.id, num_available: 8, num_consumed: 20, size: 12, packaging: "can", rating: 3.5)
sb6 = ConsumerBeer.create(beer_id: finback_starchild.id, consumer_id: shane.id, num_available: 4, num_consumed: 4, size: 12, packaging: "can", rating: 4)
sb7 = ConsumerBeer.create(beer_id: finback_ipa.id, consumer_id: shane.id, num_available: 2, num_consumed: 2, size: 12, packaging: "can", rating: 3)

jb1 = ConsumerBeer.create(beer_id: robot_fish.id, consumer_id: josh.id, num_available: 4, num_consumed: 4, size: 12, packaging: "can", rating: 4.5)
jb2 = ConsumerBeer.create(beer_id: fb_juicy.id, consumer_id: josh.id, num_available: 8, num_consumed: 4, size: 12, packaging: "can", rating: 3.5)
jb3 = ConsumerBeer.create(beer_id: vliet.id, consumer_id: josh.id, num_available: 4, num_consumed: 35, size: 12, packaging: "can", rating: 4)
jb4 = ConsumerBeer.create(beer_id: bk_lager.id, consumer_id: josh.id, num_available: 1, num_consumed: 5, size: 12, packaging: "bottle", rating: 3)
jb5 = ConsumerBeer.create(beer_id: bk_sour.id, consumer_id: josh.id, num_available: 5, num_consumed: 1, size: 12, packaging: "bottle", rating: 3.5)
jb5 = ConsumerBeer.create(beer_id: bk_sour.id, consumer_id: josh.id, num_available: 5, num_consumed: 1, size: 12, packaging: "bottle", rating: 3.5)

skb1 = ConsumerBeer.create(beer_id: fb_juicy.id, consumer_id: sukrit.id, num_available: 5, num_consumed: 13, size: 12, packaging: "can", rating: 3.5)
skb2 = ConsumerBeer.create(beer_id: robot_fish.id, consumer_id: sukrit.id, num_available: 5, num_consumed: 3, size: 12, packaging: "can", rating: 5)
skb3 = ConsumerBeer.create(beer_id: no_more.id, consumer_id: sukrit.id, num_available: 3, num_consumed: 1, size: 12, packaging: "can", rating: 4.5)
skb4 = ConsumerBeer.create(beer_id: fb_pilsner.id, consumer_id: sukrit.id, num_available: 6, num_consumed: 300, size: 12, packaging: "can", rating: 4)
skb5 = ConsumerBeer.create(beer_id: fb_lager.id, consumer_id: sukrit.id, num_available: 7, num_consumed: 1, size: 12, packaging: "can", rating: 3)




#Extras

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

# yuengling = Brewery.create(name: "D. G. Yuengling & Son Inc.", location: "Pennsylvania", specialty: "Lager", year_founded: 1829)
# new_belgium = Brewery.create(name: "New Belgium Brewing Co.", location: "Colorado", specialty: "Belgian White", year_founded: 1988)
# sam_adams = Beer.create(brewery_id: boston_beer.id, name: "Samuel Adams Boston Lager", style: "Lager", additions: "", abv: 5.0)
# angry_orchard = Beer.create(brewery_id: boston_beer.id, name: "Angry Orchard Hard Cider", style: "Cider", additions: "", abv: 5.0)
# sierra_nevada_pale = Beer.create(brewery_id: sierra_nevada.id, name: "Sierra Nevada Pale Ale", style: "Pale Ale", additions: "", abv: 5.6)
# narwhal = Beer.create(brewery_id: sierra_nevada.id, name: "Narwhal", style: "Stout", additions: "", abv: 10.2)
# fat_tire = Beer.create(brewery_id: new_belgium.id, name: "Fat Tire Belgian White", style: "Belgian White", additions: "", abv: 5.2)
# voodoo_ranger = Beer.create(brewery_id: new_belgium.id, name: "Voodoo Ranger IPA", style: "IPA", additions: "", abv: 7.0)
# oberon = Beer.create(brewery_id: bells.id, name: "Oberon", style: "Wheat", additions: "", abv: 5.8)
# two_hearted = Beer.create(brewery_id: bells.id, name: "Two Hearted Ale", style: "IPA", additions: "", abv: 7)

# yuengling_golden = Beer.create(brewery_id: yuengling.id, name: "Yuengling Golden Pilsner", style: "Pilsner", additions: "", abv: 4.7)
# yuengling_lager = Beer.create(brewery_id: yuengling.id, name: "Yuengling Traditional Lager", style: "Lager", additions: "", abv: 4.5)

puts "gettin' drunk"
