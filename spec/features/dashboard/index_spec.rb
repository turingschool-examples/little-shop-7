require "rails_helper"

RSpec.describe "Dashboard index" do
  before(:each) do
    @merchant_1 = Merchant.create!(name: "Walmart")
    @customer_1 = Customer.create!(first_name: "Bob", last_name: "App")
    @customer_2 = Customer.create!(first_name: "Lane", last_name: "C")
    @customer_3 = Customer.create!(first_name: "Bill", last_name: "Smith")
    @customer_4 = Customer.create!(first_name: "Jose", last_name: "Sanchez")
    @customer_5 = Customer.create!(first_name: "Brisa", last_name: "G")
    @customer_6 = Customer.create!(first_name: "Martin", last_name: "C")

    @invoice_1 = Invoice.create!(status:1, customer_id: @customer_1.id)
    @invoice_2 = Invoice.create!(status:1, customer_id: @customer_2.id)
    @invoice_3 = Invoice.create!(status:1, customer_id: @customer_3.id)
    @invoice_4 = Invoice.create!(status:1, customer_id: @customer_4.id)
    @invoice_5 = Invoice.create!(status:1, customer_id: @customer_5.id)
    @invoice_6 = Invoice.create!(status:1, customer_id: @customer_6.id)
    @invoice_7 = Invoice.create!(status:1, customer_id: @customer_1.id)
    
    @transaction_1 = Transaction.create!(invoice_id:@invoice_1.id, credit_card_number: "353535353", credit_card_expiration_date: "12/34", result: 0  )
    @transaction_2 = Transaction.create!(invoice_id:@invoice_2.id, credit_card_number: "353535353", credit_card_expiration_date: "12/34", result: 0  )
    @transaction_3 = Transaction.create!(invoice_id:@invoice_3.id, credit_card_number: "353535353", credit_card_expiration_date: "12/34", result: 0  )
    @transaction_4 = Transaction.create!(invoice_id:@invoice_1.id, credit_card_number: "353535353", credit_card_expiration_date: "12/34", result: 0  )
    @transaction_5 = Transaction.create!(invoice_id:@invoice_4.id, credit_card_number: "353535353", credit_card_expiration_date: "12/34", result: 0  )
    @transaction_5 = Transaction.create!(invoice_id:@invoice_1.id, credit_card_number: "353535353", credit_card_expiration_date: "12/34", result: 0  )
    @transaction_7 = Transaction.create!(invoice_id:@invoice_5.id, credit_card_number: "353535353", credit_card_expiration_date: "12/34", result: 0  )
    @transaction_8 = Transaction.create!(invoice_id:@invoice_6.id, credit_card_number: "353535353", credit_card_expiration_date: "12/34", result: 0  )
    require 'pry'; binding.pry
    @transaction_9 = Transaction.create!(invoice_id:@invoice_1.id, credit_card_number: "353535353", credit_card_expiration_date: "12/34", result: 0  )
  end

  describe 'US1' do
    it 'shows the name of my merchant' do
      visit merchant_dashboard_index_path(@merchant_1)

      expect(page).to have_content(@merchant_1.name)
    end
  end

  describe 'US 2' do
    it ' link to my merchant items index' do
      visit merchant_dashboard_index_path(@merchant_1)

      expect(page).to have_link('My Items')

      click_link("My Items")

      expect(current_path).to eq(merchant_items_path(@merchant_1))
    end

    it 'link to my merchant invoices index ' do
      visit merchant_dashboard_index_path(@merchant_1)

      expect(page).to have_link('My Invoices')

      click_link("My Invoices")

      expect(current_path).to eq(merchant_invoices_path(@merchant_1))
    
    end
  end

  describe 'US 3' do
    it 'displays top 5 customers' do
      visit merchant_dashboard_index_path(@merchant_1)
      
      expect(page).to have_content('Top 5 Customers')

      # save_and_open_page
      expect(page).to have_content(@customer_1.first_name)
      expect(page).to have_content(@customer_1.last_name)
      # expect(page).to have_content('4')



    end
  end
end