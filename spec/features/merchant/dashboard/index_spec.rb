require "rails_helper"
RSpec.describe "Merchant Dashboards", type: :feature do
  before(:each) do 
    @merchants = create_list(:merchant, 10)
    @customers = create_list(:customer, 10)
    @invoices = create_list(:invoice, 20)
    @items = create_list(:item, 5)
    @invoice_items = create_list(:invoice_item, 20)
    @transactions = create_list(:transaction, 5)
  end 

  it "shows the name of the merchant" do 
    visit "/merchants/#{@merchants.first.id}/dashboard"

    expect(page).to have_content(@merchants.first.name)
  end

  it "has links to the merchant items index and the merchant invoices index" do 
    visit "/merchants/#{@merchants.last.id}/dashboard"
    
    expect(page).to have_link("Invoices")
    expect(page).to have_link("Items")

    click_link "Items" 
    expect(current_path).to eq("/merchants/#{@merchants.last.id}/items")

    visit "/merchants/#{@merchants.first.id}/dashboard"

    click_link "Invoices" 
    expect(current_path).to eq("/merchants/#{@merchants.first.id}/invoices")
  end

  it "has a list of the top five customers who have conducted the largest number of transactions with a merchant" do 
    load_data

    visit "/merchants/#{@merchants.first.id}/dashboard"
    require 'pry'; binding.pry
    create_transaction(5, 10)
    
  end

end 