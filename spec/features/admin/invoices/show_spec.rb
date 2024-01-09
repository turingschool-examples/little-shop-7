require 'rails_helper'

RSpec.describe 'Admin Show Spec', type: :feature do
  describe 'as an admin' do
    before(:each) do
      @merch_1 = Merchant.create!(name: "Walmart", status: :enabled)
      @merch_2 = Merchant.create!(name: "Target", status: :disabled)
      @merch_3 = Merchant.create!(name: "PetSmart", status: :disabled)
      @merch_4 = Merchant.create!(name: "GameStop", status: :enabled)
      @merch_5 = Merchant.create!(name: "Sams", status: :enabled)
      @merch_6 = Merchant.create!(name: "Costco", status: :enabled)
  
      @item_1 = @merch_1.items.create!(name: "Apple", description: "red apple", unit_price:1)
      @item_2 = @merch_1.items.create!(name: "Orange", description: "orange orange", unit_price:1)
      @item_3 = @merch_2.items.create!(name: "Blood Orange", description: "blood orange", unit_price:1)
      @item_4 = @merch_2.items.create!(name: "Grape", description: "Red Grape", unit_price:1)
      @item_5 = @merch_3.items.create!(name: "Dragon fruit", description: "Red", unit_price:1)
      @item_6 = @merch_3.items.create!(name: "plum", description: "Good", unit_price:1)
      @item_7 = @merch_4.items.create!(name: "tacos", description: "tortilla", unit_price:1)
      @item_8 = @merch_4.items.create!(name: "gum", description: "mint", unit_price:1)
      @item_9 = @merch_5.items.create!(name: "pasta", description: "Italian", unit_price:1)
      @item_10 = @merch_5.items.create!(name: "Rum", description: "Yum", unit_price:1)
      @item_11 = @merch_6.items.create!(name: "Vodka", description: "White", unit_price:1)
      @item_12 = @merch_6.items.create!(name: "Cat Toy", description: "toy", unit_price:1)
  
      @cust_1 = Customer.create!(first_name: "Larry", last_name: "Johnson")
      @cust_2 = Customer.create!(first_name: "Pam", last_name: "Nelson")
      @cust_3 = Customer.create!(first_name: "Logan", last_name: "Finnegan")
      @cust_4 = Customer.create!(first_name: "Nate", last_name: "Lambertson")
      @cust_5 = Customer.create!(first_name: "Martin", last_name: "chavez")
      @cust_6 = Customer.create!(first_name: "Isaac", last_name: "Mitchell")
  
      @inv_1 = @cust_1.invoices.create!(status: :completed, created_at:Time.new(2021, 10, 31) )
      @inv_2 = @cust_2.invoices.create!(status: :completed)
      @inv_3 = @cust_3.invoices.create!(status: :completed)
      @inv_4 = @cust_4.invoices.create!(status: :completed)
      @inv_5 = @cust_5.invoices.create!(status: :in_progress,created_at:Time.new(2024, 02, 1))
      @inv_6 = @cust_6.invoices.create!(status: :cancelled, created_at:Time.new(2021, 10, 31))
  
      @tran_1 = @inv_1.transactions.create!(credit_card_number: "2222 2222 2222 2222", credit_card_expiration_date: "01/2021", result: :success )
      @tran_2 = @inv_2.transactions.create!(credit_card_number: "2222 2222 2222 2222", credit_card_expiration_date: "02/2022", result: :success )
      @tran_3 = @inv_3.transactions.create!(credit_card_number: "2222 2222 2222 2222", credit_card_expiration_date: "03/2023", result: :success )
      @tran_4 = @inv_4.transactions.create!(credit_card_number: "2222 2222 2222 2222", credit_card_expiration_date: "04/2024", result: :success )
      @tran_5 = @inv_5.transactions.create!(credit_card_number: "2222 2222 2222 2222", credit_card_expiration_date: "05/2025", result: :success )
      @tran_6 = @inv_6.transactions.create!(credit_card_number: "2222 2222 2222 2222", credit_card_expiration_date: "06/2026", result: :failed )
  
      @ii_1 = InvoiceItem.create!(invoice: @inv_1, item: @item_1, quantity: 10, unit_price: 1, status: :shipped )
      @ii_2 = InvoiceItem.create!(invoice: @inv_1, item: @item_2, quantity: 10, unit_price: 1, status: :shipped )
      @ii_3 = InvoiceItem.create!(invoice: @inv_1, item: @item_3, quantity: 10, unit_price: 1, status: :shipped )
      @ii_4 = InvoiceItem.create!(invoice: @inv_2, item: @item_1, quantity: 10, unit_price: 1, status: :shipped )
      @ii_5 = InvoiceItem.create!(invoice: @inv_2, item: @item_2, quantity: 10, unit_price: 1, status: :shipped )
      @ii_6 = InvoiceItem.create!(invoice: @inv_2, item: @item_3, quantity: 10, unit_price: 1, status: :shipped )
    end
    
    # 33. Admin Invoice Show Page
    it 'shows invoice data' do
      # When I visit an admin invoice show page (/admin/invoices/:invoice_id)
      visit  admin_invoice_path(@inv_1)
      # Then I see information related to that invoice including:
      # - Invoice id
      # - Invoice status
      # - Invoice created_at date in the format "Monday, July 18, 2019"
      # - Customer first and last name
      expect(page).to have_content(@inv_1.id)
      expect(page).to have_content(@inv_1.status)
      expect(page).to have_content(@inv_1.created_at.strftime("%A, %B %d, %Y"))
      expect(page).to have_content(@inv_1.customer.full_name)
    end
  end
end