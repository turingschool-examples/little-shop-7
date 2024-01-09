# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
    merch_1 = Merchant.create!(name: "Walmart", status: :enabled)
    merch_2 = Merchant.create!(name: "Target", status: :enabled)
    merch_3 = Merchant.create!(name: "PetSmart", status: :enabled)
    merch_4 = Merchant.create!(name: "GameStop", status: :enabled)
    merch_5 = Merchant.create!(name: "Sams", status: :enabled)
    merch_6 = Merchant.create!(name: "Costco", status: :enabled)

    @cust_1 = Customer.create!(first_name: "Larry", last_name: "Johnson")
    @cust_2 = Customer.create!(first_name: "Pam", last_name: "Nelson")
    @cust_3 = Customer.create!(first_name: "Logan", last_name: "Finnegan")
    @cust_4 = Customer.create!(first_name: "Nate", last_name: "Lambertson")
    @cust_5 = Customer.create!(first_name: "Martin", last_name: "chavez")
    @cust_6 = Customer.create!(first_name: "Isaac", last_name: "Mitchell")

    item_1 = merch_1.items.create!(name: "Apple", description: "red apple", unit_price:1)
    item_3 = merch_2.items.create!(name: "Blood Orange", description: "blood orange", unit_price:1)
    item_5 = merch_3.items.create!(name: "Dragon fruit", description: "Red", unit_price:1)
    item_7 = merch_4.items.create!(name: "tacos", description: "tortilla", unit_price:1)
    item_9 = merch_5.items.create!(name: "pasta", description: "Italian", unit_price:1)
    item_11 = merch_6.items.create!(name: "Vodka", description: "White", unit_price:1)

    inv_1 = @cust_1.invoices.create!(status: :completed )
    inv_2 = @cust_2.invoices.create!(status: :completed)
    inv_3 = @cust_3.invoices.create!(status: :completed)
    inv_4 = @cust_4.invoices.create!(status: :completed)
    inv_5 = @cust_5.invoices.create!(status: :completed)
    inv_6 = @cust_6.invoices.create!(status: :completed)
   
    tran_1 = inv_1.transactions.create!(credit_card_number: "2222 2222 2222 2222", credit_card_expiration_date: "01/2021", result: :success )
    tran_2 = inv_2.transactions.create!(credit_card_number: "2222 2222 2222 2222", credit_card_expiration_date: "02/2022", result: :success )
    tran_3 = inv_3.transactions.create!(credit_card_number: "2222 2222 2222 2222", credit_card_expiration_date: "03/2023", result: :success )
    tran_4 = inv_4.transactions.create!(credit_card_number: "2222 2222 2222 2222", credit_card_expiration_date: "04/2024", result: :success )
    tran_5 = inv_5.transactions.create!(credit_card_number: "2222 2222 2222 2222", credit_card_expiration_date: "05/2025", result: :success )
    tran_6 = inv_6.transactions.create!(credit_card_number: "2222 2222 2222 2222", credit_card_expiration_date: "06/2026", result: :success )

    ii_1 = InvoiceItem.create!(invoice: inv_1, item: item_1, quantity: 1000, unit_price: 1, status: :shipped )
    ii_2 = InvoiceItem.create!(invoice: inv_2, item: item_3, quantity: 250, unit_price: 1, status: :shipped )
    ii_3 = InvoiceItem.create!(invoice: inv_3, item: item_5, quantity: 300, unit_price: 1, status: :shipped )
    ii_4 = InvoiceItem.create!(invoice: inv_4, item: item_7, quantity: 100, unit_price: 1, status: :shipped )
    ii_5 = InvoiceItem.create!(invoice: inv_5, item: item_9, quantity: 600, unit_price: 1, status: :shipped )
    ii_6 = InvoiceItem.create!(invoice: inv_6, item: item_11, quantity: 10, unit_price: 1, status: :shipped )