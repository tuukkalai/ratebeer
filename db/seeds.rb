# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

b1 = Brewery.create name: "Sinebrychoff", year: 1819
b2 = Brewery.create name: "Malmgårdin panimo", year: 2009
b3 = Brewery.create name: "Weihenstephaner", year: 1040
b4 = Brewery.create name: "Laitilan Wirvoitusjuomatehdas", year: 1995

b1.beers.create name: "Koff", style: "Lager"
b1.beers.create name: "Karhu", style: "Lager"
b1.beers.create name: "Karhu Tuplahumala", style: "Lager"
b2.beers.create name: "Huvila Pale Ale", style: "Pale Ale"
b2.beers.create name: "X Porter", style: "Porter"
b3.beers.create name: "Hefeweizen", style: "Weizen"
b3.beers.create name: "Helles", style: "Lager"
b4.beers.create name: "Kukko Pils", style: "Pilsner"
b4.beers.create name: "Kukko Lager", style: "Lager"
b4.beers.create name: "Kukko Bitter", style: "Bitter"
b4.beers.create name: "Kukko IPA", style: "Pale Ale"
b4.beers.create name: "Kukko Red Ale", style: "Ale"
b4.beers.create name: "Kukko Tumma", style: "Porter"
b4.beers.create name: "Kukko Vehnä", style: "Weizen"