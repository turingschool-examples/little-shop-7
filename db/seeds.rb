# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

customer_1 = Customer.create(first_name: "1", last_name: "11")
customer_6 = Customer.create(first_name: "Not a Name", last_name: "Not a Last Name")
customer_5 = Customer.create(first_name: "5", last_name: "55")
customer_2 = Customer.create(first_name: "2", last_name: "22")
customer_4 = Customer.create(first_name: "4", last_name: "44")
customer_3 = Customer.create(first_name: "3", last_name: "33")


top_5_customers = [customer_1, customer_2, customer_3, customer_4, customer_5]

top_5_customers.each_with_index do |customer, index|
  invoice = Invoice.create(status: 1, customer: customer)
  (10 - index).times {Transaction.create(invoice: invoice, credit_card_number: "1234 5678 9012 3456", credit_card_expiration_date: "09/28", result: 1) }
end

invoice = Invoice.create(status: 1, customer: customer_6)
10.times {Transaction.create(invoice: invoice, credit_card_number: "1234 5678 9012 3456", credit_card_expiration_date: "09/28", result: 0) }
5.times {Transaction.create(invoice: invoice, credit_card_number: "1234 5678 9012 3456", credit_card_expiration_date: "09/28", result: 1) }
