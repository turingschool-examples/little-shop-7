# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
Merchant.destroy_all
Item.destroy_all

# Merchants
@merchant_1 = Merchant.create!(name: "John Jacob Astor")


# Items
@item_1 = @merchant_1.items.create!(name: "fur coat", description: "a fur coat acquired ethically and legally", unit_price: 1000)
@item_2 = @merchant_1.items.create!(name: "opium", description: "only the finest, acquired ethically and legally", unit_price: 2000)
@item_3 = @merchant_1.items.create!(name: "land tract", description: "prime real estate in the future home of astoria queens", unit_price: 5000)