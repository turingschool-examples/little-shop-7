require 'rails_helper'

RSpec.describe 'Admin Merchants Show', type: :feature do
 describe 'As an Admin' do
  before(:each) do
    @customer_1 = create(:customer)
    @customer_2 = create(:customer)
    @customer_3 = create(:customer)
    @customer_4 = create(:customer)
    @customer_5 = create(:customer)
    @customer_6 = create(:customer)

    @invoice_1 = create(:invoice, customer_id: @customer_1.id)
    @invoice_2 = create(:invoice, customer_id: @customer_2.id)
    @invoice_3 = create(:invoice, customer_id: @customer_3.id)
    @invoice_4 = create(:invoice, customer_id: @customer_4.id)
    @invoice_5 = create(:invoice, customer_id: @customer_5.id)
    @invoice_6 = create(:invoice, customer_id: @customer_6.id)
    @invoice_7 = create(:invoice, customer_id: @customer_5.id, status: 0, created_at: "Wed, 21 Feb 2024 00:47:11.096539000 UTC +00:00")
    @invoice_8 = create(:invoice, customer_id: @customer_5.id, status: 0, created_at: "Tues, 20 Feb 2024 00:47:11.096539000 UTC +00:00")
    @invoice_9 = create(:invoice, customer_id: @customer_5.id, status: 0, created_at: "Mon, 19 Feb 2024 00:47:11.096539000 UTC +00:00")

    @trans_1 = create(:transaction, invoice_id: @invoice_1.id)
    @trans_2 = create(:transaction, invoice_id: @invoice_1.id)
    @trans_3 = create(:transaction, invoice_id: @invoice_1.id)
    @trans_4 = create(:transaction, invoice_id: @invoice_1.id)
    @trans_5 = create(:transaction, invoice_id: @invoice_1.id)
    @trans_6 = create(:transaction, invoice_id: @invoice_2.id)
    @trans_7 = create(:transaction, invoice_id: @invoice_2.id)
    @trans_8 = create(:transaction, invoice_id: @invoice_2.id)
    @trans_9 = create(:transaction, invoice_id: @invoice_2.id)
    @trans_10 = create(:transaction, invoice_id: @invoice_3.id)
    @trans_11 = create(:transaction, invoice_id: @invoice_3.id)
    @trans_12 = create(:transaction, invoice_id: @invoice_3.id)
    @trans_13 = create(:transaction, invoice_id: @invoice_4.id)
    @trans_14 = create(:transaction, invoice_id: @invoice_4.id)
    @trans_15 = create(:transaction, invoice_id: @invoice_5.id)
    
    @merchant_1 = create(:merchant, name: "Amazon") 
    @merchant_4 = create(:merchant, name: "Walmart") 
    @merchant_5 = create(:merchant, name: "Apple") 
    @merchant_6 = create(:merchant, name: "Microsoft") 

    @item_1 = create(:item, unit_price: 1, merchant_id: @merchant_1.id)
    @item_2 = create(:item, unit_price: 1, merchant_id: @merchant_1.id)
    @item_3 = create(:item, unit_price: 1, merchant_id: @merchant_1.id)
    @item_4 = create(:item, unit_price: 1, merchant_id: @merchant_1.id)
    @item_5 = create(:item, unit_price: 1, merchant_id: @merchant_1.id)

    @invoice_item_1 = create(:invoice_item, item_id: @item_1.id, invoice_id: @invoice_1.id, quantity: 1, unit_price: 1300, status: 0)
    @invoice_item_2 = create(:invoice_item, item_id: @item_2.id, invoice_id: @invoice_2.id, quantity: 1, unit_price: 1300, status: 0)
    @invoice_item_3 = create(:invoice_item, item_id: @item_3.id, invoice_id: @invoice_3.id, quantity: 1, unit_price: 1300, status: 1)
    @invoice_item_4 = create(:invoice_item, item_id: @item_4.id, invoice_id: @invoice_4.id, quantity: 1, unit_price: 1300, status: 2)
    @invoice_item_5 = create(:invoice_item, item_id: @item_5.id, invoice_id: @invoice_5.id, quantity: 1, unit_price: 1300, status: 2)
    @invoice_item_6 = create(:invoice_item, item_id: @item_5.id, invoice_id: @invoice_7.id, quantity: 1, unit_price: 1300, status: 0)
    @invoice_item_7 = create(:invoice_item, item_id: @item_5.id, invoice_id: @invoice_8.id, quantity: 1, unit_price: 1300, status: 0)
    @invoice_item_8 = create(:invoice_item, item_id: @item_5.id, invoice_id: @invoice_9.id, quantity: 1, unit_price: 1300, status: 0)
  end

  #User Story 25. Admin Merchant Show
  it 'displays merchants name' do
    # As an admin, When I click on the name of a merchant from the admin merchants index page (/admin/merchants),
    visit admin_merchants_path
    click_link("Amazon")
    # Then I am taken to that merchant's admin show page (/admin/merchants/:merchant_id)
    expect(current_path).to eq(admin_merchant_path(@merchant_1.id))
    # And I see the name of that merchant    
    expect(page).to have_content("Amazon")
  end

  #User Story 26.
  it 'displays a link to update merchants information, and updates it successfully' do
    # As an admin,
    # When I visit a merchant's admin show page (/admin/merchants/:merchant_id)
    visit admin_merchant_path(@merchant_1.id)
    # Then I see a link to update the merchant's information. When I click the link

    click_link("Update #{@merchant_1.name}'s Information")
    # Then I am taken to a page to edit this merchant
    expect(current_path).to eq(edit_admin_merchant_path(@merchant_1.id))

    #Test continues in spec/features/admin/merchants/edit_spec.rb
  end
 end
end