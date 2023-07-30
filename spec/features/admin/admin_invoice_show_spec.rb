require 'rails_helper'

RSpec.describe "Admin Invoice Show Page", type: :feature do
  before :each do
    @merchant_1 = Merchant.create!(name: "Bob's Burgers")
    @merchant_2 = Merchant.create!(name: "Kwik-E-Mart")
    
    @customer_1 = Customer.create!(first_name: "Marge", last_name: "Simpson")
    @customer_2 = Customer.create!(first_name: "Joe", last_name: "Swanson")
    @customer_3 = Customer.create!(first_name: "Linda", last_name: "Belcher")

    @invoice_1 = Invoice.create!(customer_id: @customer_1.id, status: 1)
    @invoice_2 = Invoice.create!(customer_id: @customer_1.id, status: 0)
    @invoice_3 = Invoice.create!(customer_id: @customer_2.id, status: 1)
    @invoice_4 = Invoice.create!(customer_id: @customer_2.id, status: 1)
    @invoice_5 = Invoice.create!(customer_id: @customer_3.id, status: 0)
    @invoice_6 = Invoice.create!(customer_id: @customer_3.id, status: 1)

    @item_1 = Item.create!(name: "Burger", description: "Delicious", unit_price: 450, merchant_id: @merchant_1.id)
    @item_2 = Item.create!(name: "Fries", description: "Salty", unit_price: 250, merchant_id: @merchant_1.id)
    @item_3 = Item.create!(name: "Squishee", description: "Slushy", unit_price: 150, merchant_id: @merchant_2.id)
    @item_4 = Item.create!(name: "Hot Dog", description: "Tasty", unit_price: 300, merchant_id: @merchant_2.id)
    @item_5 = Item.create!(name: "Wine", description: "It makes you drink", unit_price: 2000, merchant_id: @merchant_2.id)
    @item_6 = Item.create!(name: "Cheese", description: "It goes well with winr", unit_price: 1375, merchant_id: @merchant_2.id)

    @invoice_item_1 = InvoiceItem.create!(item_id: @item_1.id, invoice_id: @invoice_1.id, quantity: 10, unit_price: 450, status: 1)
    @invoice_item_2 = InvoiceItem.create!(item_id: @item_2.id, invoice_id: @invoice_1.id, quantity: 5, unit_price: 250, status: 1)
    @invoice_item_3 = InvoiceItem.create!(item_id: @item_3.id, invoice_id: @invoice_2.id, quantity: 1, unit_price: 150, status: 1)
    @invoice_item_4 = InvoiceItem.create!(item_id: @item_4.id, invoice_id: @invoice_2.id, quantity: 2, unit_price: 300, status: 1)
    @invoice_item_5 = InvoiceItem.create!(item_id: @item_5.id, invoice_id: @invoice_3.id, quantity: 3, unit_price: 2000, status: 1)
    @invoice_item_6 = InvoiceItem.create!(item_id: @item_6.id, invoice_id: @invoice_3.id, quantity: 4, unit_price: 1375, status: 1)

  end
  # US 33  
  it "I can see each invoice id links to the admin invoice show page" do

    visit admin_invoices_path
    click_link(@invoice_1.id)

    expect(current_path).to eq(admin_invoice_path(@invoice_1))
    expect(page).to have_content(@invoice_1.id)
    expect(page).to have_content(@invoice_1.status)
    expect(page).to have_content(@invoice_1.created_at.strftime("%A, %B %d, %Y"))
    expect(page).to have_content(@customer_1.first_name)
    expect(page).to have_content(@customer_1.last_name)
    expect(page).not_to have_content(@customer_2.first_name)
  end

  # US 34
  it "I can see all of the item information on the invoice" do

    visit admin_invoice_path(@invoice_1)

    expect(page).to have_content(@item_1.name)
    expect(page).to have_content(@invoice_item_1.quantity)
    expect(page).to have_content(@invoice_item_1.unit_price)
    expect(page).to have_content(@invoice_item_1.status)
    expect(page).to have_content(@item_2.name)
    expect(page).to have_content(@invoice_item_2.quantity)
    expect(page).to have_content(@invoice_item_2.unit_price)
    expect(page).to have_content(@invoice_item_2.status)
    expect(page).not_to have_content(@item_3.name)
  end
end
