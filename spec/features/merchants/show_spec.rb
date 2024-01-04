require "rails_helper"

RSpec.describe "show page" do
  before (:each) do
    @merchant_1 = Merchant.create!(name: "Walmart")
    @items = create_list(:item, 31, merchant: @merchant_1)
    @customers = create_list(:customer, 13)
    @customers_with_transactions = create_list(:customer_with_transactions, 10)
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
    visit "/merchants/#{@merchant_1.id}/dashboard"
    customer0 = @customers[0], customer1 = @customers[1], customer2 = @customers[2], customer3 = @customers[3]
    customer4 = @customers[4], customer5 = @customers[5], customer6 = @customers[6], customer7 = @customers[7]




  end
  # Merchant Dashboard Statistics - Favorite Customers: As a merchant,
  # When I visit my merchant dashboard (/merchants/:merchant_id/dashboard)
  # Then I see the names of the top 5 customers who have conducted the largest number of
  # successful transactions with my merchant And next to each customer name I see the number of
  # successful transactions they have conducted with my merchant
end
