{InvoiceItem}.destroy_all
{Transaction}.destroy_all
{Invoice}.destroy_all
{Item}.destroy_all
{Merchant}.destroy_all
{Customer}.destroy_all
system("rails csv_load:all")
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
