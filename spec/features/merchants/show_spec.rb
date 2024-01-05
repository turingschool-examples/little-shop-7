require "rails_helper"

RSpec.describe "show page" do
  before (:each) do
    @merchant_1 = Merchant.create!(name: "Walmart")
    @items = create_list(:item, 31, merchant: @merchant_1)
    @customers = create_list(:customer, 13)
    @customers_with_transactions = create_list(:customer_with_transactions, 13)
    @invoices = create_list(:invoice, 43)
  end

  it "displays the merchant name on the dashboard page" do

    visit "/merchants/#{@merchant_1.id}/dashboard"

    expect(page).to have_content(@merchant_1.name)
  end

  it "has a link to the merchant items index, and a link to the merchant invoices index" do

    visit "/merchants/#{@merchant_1.id}/dashboard"

    expect(page).to have_link("Items")
    expect(page).to have_link("Invoices")
  end

  it "shows name of the top 5 customers based on largest number of successful purchases and their total number of orders" do
    customer1 = Customer.create!(first_name: "John", last_name: "Smith")
    customer2 = Customer.create!(first_name: "Jane", last_name: "Sornes")
    customer3 = Customer.create!(first_name: "Jaques", last_name: "Snipes")
    customer4 = Customer.create!(first_name: "Jay", last_name: "Snape")
    customer5 = Customer.create!(first_name: "Tom", last_name: "Bullocks")
    customer6 = Customer.create!(first_name: "Jimmy", last_name: "Dirt")
    customer7 = Customer.create!(first_name: "Helva", last_name: "Harrock")
    invoice1 = customer1.invoices.create!(status: 2)
    invoice2 = customer2.invoices.create!(status: 2)
    invoice3 = customer3.invoices.create!(status: 2)
    invoice4 = customer4.invoices.create!(status: 2)
    invoice5 = customer5.invoices.create!(status: 2)
    invoice5 = customer6.invoices.create!(status: 2)
    invoice5 = customer7.invoices.create!(status: 2)
    transaction1 = invoice1.transactions.create!(credit_card_number: 1234547890123456, credit_card_expiration_date: "04/26", result: 0)
    transaction2 = invoice1.transactions.create!(credit_card_number: 1234567897123456, credit_card_expiration_date: "04/26", result: 0)
    transaction3 = invoice1.transactions.create!(credit_card_number: 1234567892123453, credit_card_expiration_date: "04/26", result: 0)
    transaction4 = invoice1.transactions.create!(credit_card_number: 2234567890123456, credit_card_expiration_date: "04/26", result: 0)
    transaction5 = invoice1.transactions.create!(credit_card_number: 1238567890123476, credit_card_expiration_date: "04/26", result: 0)
    transaction6 = invoice2.transactions.create!(credit_card_number: 1238567590123476, credit_card_expiration_date: "04/26", result: 1)
    transaction7 = invoice2.transactions.create!(credit_card_number: 1238567896123476, credit_card_expiration_date: "04/26", result: 0)
    transaction8 = invoice2.transactions.create!(credit_card_number: 1278567890123476, credit_card_expiration_date: "04/26", result: 0)
    transaction9 = invoice2.transactions.create!(credit_card_number: 1238567890183476, credit_card_expiration_date: "04/26", result: 0)
    transaction10 = invoice3.transactions.create!(credit_card_number: 1238634646123476, credit_card_expiration_date: "04/26", result: 1)
    transaction11 = invoice3.transactions.create!(credit_card_number: 1238566836478476, credit_card_expiration_date: "04/26", result: 0)
    transaction12 = invoice3.transactions.create!(credit_card_number: 1238567890122476, credit_card_expiration_date: "04/26", result: 0)
    transaction13 = invoice4.transactions.create!(credit_card_number: 1238567876567476, credit_card_expiration_date: "04/26", result: 1)
    transaction13 = invoice4.transactions.create!(credit_card_number: 1238567230128476, credit_card_expiration_date: "04/26", result: 0)
    transaction15 = invoice3.transactions.create!(credit_card_number: 1238553460128476, credit_card_expiration_date: "04/26", result: 1)

    visit "/merchants/#{@merchant_1.id}/dashboard"

    expect(page).to have_content("Top 5 Customers")
    expect(page).to have_content("#{customer1.first_name} #{customer1.last_name} Successful Purchases: 5")
    expect(page).to have_content("#{customer2.first_name} #{customer2.last_name} Successful Purchases: 4")
    expect(page).to have_content("#{customer3.first_name} #{customer3.last_name} Successful Purchases: 3")
    expect(page).to have_content("#{customer4.first_name} #{customer4.last_name} Successful Purchases: 2")
    expect(page).to have_content("#{customer5.first_name} #{customer5.last_name} Successful Purchases: 1")
  end
end
