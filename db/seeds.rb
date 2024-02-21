# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

cust_1 = Customer.create!(first_name: "Joey", last_name: "Ondricka")
cust_2 = Customer.create!(first_name: "John", last_name: "Smith")
cust_3 = Customer.create!(first_name: "Jane", last_name: "Perry")
cust_4 = Customer.create!(first_name: "Buzz", last_name: "Lightyeay")
cust_5 = Customer.create!(first_name: "Patrick", last_name: "Karl")
cust_6 = Customer.create!(first_name: "Igor", last_name: "Mag")
cust_7 = Customer.create!(first_name: "Selena", last_name: "Has")
cust_8 = Customer.create!(first_name: "Martin", last_name: "Des")
cust_9 = Customer.create!(first_name: "Carl", last_name: "Johnson")
cust_10 = Customer.create!(first_name: "Peter", last_name: "Petigurew")

# inv_1 = Invoice.create!(status: )