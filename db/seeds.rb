# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

items = Item.create([
  {title: "Mod Sofa", price: 1900, location: "Santa Monica"},
  {title: "Mod Chair and Ottoman", price: 900, location: "Silver Lake"},
  {title: "Mod Credenza", price: 1500, location: "Pasadena"}
])
