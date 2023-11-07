require 'rails_helper'

RSpec.describe "Admin Merchants Index", type: :feature do
  before :each do
    # Create merchants
    @merchant1 = create(:merchant)
    @merchant2 = create(:merchant)
    @merchant3 = create(:merchant)
    @merchant4 = create(:merchant)
    @merchant5 = create(:merchant)

    puts "Merchant 1 ID: #{@merchant1.id}"
    puts "Merchant 1 Name: #{@merchant1.name}"

    @customer1 = create(:customer)
    @customer2 = create(:customer)
    @customer3 = create(:customer)
    @customer4 = create(:customer)
    @customer5 = create(:customer)

    @invoice1 = create(:invoice, customer: @customer1)
    @invoice2 = create(:invoice, customer: @customer2)
    @invoice3 = create(:invoice, customer: @customer3)
    @invoice4 = create(:invoice, customer: @customer4)
    @invoice5 = create(:invoice, customer: @customer5)

    @item1 = create(:item, merchant: @merchant1)
    @item2 = create(:item, merchant: @merchant2)
    @item3 = create(:item, merchant: @merchant3)
    @item4 = create(:item, merchant: @merchant4)
    @item5 = create(:item, merchant: @merchant5)

    # Create invoice items with unit prices and quantities associated with invoices
    @invoice_item1 = create(:invoice_item, invoice: @invoice1, unit_price: 10, quantity: 5)
    @invoice_item2 = create(:invoice_item, invoice: @invoice2, unit_price: 15, quantity: 3)
    @invoice_item3 = create(:invoice_item, invoice: @invoice3, unit_price: 8, quantity: 5)
    @invoice_item4 = create(:invoice_item, invoice: @invoice4, unit_price: 9, quantity: 4)
    @invoice_item5 = create(:invoice_item, invoice: @invoice5, unit_price: 9, quantity: 2)

    # Create successful transactions for invoices
    @transaction1 = create(:transaction, invoice: @invoice1, result: 0) # Successful
    @transaction2 = create(:transaction, invoice: @invoice2, result: 0) # Successful
    @transaction3 = create(:transaction, invoice: @invoice3, result: 0) # Successful
    @transaction4 = create(:transaction, invoice: @invoice4, result: 0) # Successful
    @transaction5 = create(:transaction, invoice: @invoice5, result: 0) # Successful
  end

  # US 24
  it "displays the name of each merchant" do
    visit admin_merchants_path

    expect(page).to have_content(@merchant1.name)
    expect(page).to have_content(@merchant2.name)
    expect(page).to have_content(@merchant3.name)
  end

  # US 25
  it "clicking the name redirects to merchant admin show page and displays the name" do
    visit admin_merchants_path

    expect(page).to have_link("#{@merchant1.name} ##{@merchant1.id}")
    click_link("#{@merchant1.name} ##{@merchant1.id}")

    expect(current_path).to eq(admin_merchant_path(@merchant1.id))

    expect(page).to have_content(@merchant1.name)
  end

  # US 30
  it "displays the top 5 merchants by total revenue and lists total revenue generated" do
    visit admin_merchants_path
  
    puts "Merchant 1 ID: #{@merchant1.id}"

    within("#merchant-#{@merchant1.id}") do
      expect(page).to have_content("#{@merchant1.name}: $#{@merchant1.total_revenue1}")
      expect(page).to have_link("#{@merchant1.name} ##{@merchant1.id}")
      click_link("#{@merchant1.name} ##{@merchant1.id}")
    end

    expect(current_path).to eq(admin_merchant_path(@merchant1.id))
  end
end