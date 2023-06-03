require 'rails_helper'

RSpec.describe 'Merchant Dashboard' do
  before(:each) do 
    @merchant_1 = create(:merchant)
    @c1 = Customer.create!(first_name: 'Bilbo', last_name: 'Baggins')
    @c2 = Customer.create!(first_name: 'Frodo', last_name: 'Baggins')
    @c3 = Customer.create!(first_name: 'Samwise', last_name: 'Gamgee')
    @c4 = Customer.create!(first_name: 'Aragorn', last_name: 'Elessar')
    @c5 = Customer.create!(first_name: 'Arwen', last_name: 'Undomiel')
    @c6 = Customer.create!(first_name: 'Legolas', last_name: 'Greenleaf')
    
    @item_1 = @merchant_1.items.create!(name: 'Shampoo', description: 'This washes your hair', unit_price: 10)
    @item_2 = @merchant_1.items.create!(name: 'Conditioner', description: 'This makes your hair shiny', unit_price: 8)
    @item_3 = @merchant_1.items.create!(name: 'Brush', description: 'This takes out tangles', unit_price: 5)
    
    @i1 = @c1.invoices.create!(status: 2)
    @i2 = @c1.invoices.create!(status: 2)
    @i3 = @c2.invoices.create!(status: 2)
    @i4 = @c3.invoices.create!(status: 2)
    @i5 = @c3.invoices.create!(status: 2)
    
    @ii_1 = InvoiceItem.create!(invoice_id: @i1.id, item_id: @item_1.id, quantity: 1, unit_price: 10, status: 0)
    @ii_2 = InvoiceItem.create!(invoice_id: @i1.id, item_id: @item_2.id, quantity: 1, unit_price: 8, status: 0)
    @ii_3 = InvoiceItem.create!(invoice_id: @i2.id, item_id: @item_3.id, quantity: 1, unit_price: 5, status: 2)
    @ii_4 = InvoiceItem.create!(invoice_id: @i3.id, item_id: @item_3.id, quantity: 1, unit_price: 5, status: 1)
    
    @t1 = create(:transaction, invoice_id: @i1.id)
    @t2 = create(:transaction, invoice_id: @i2.id)
    @t3 = create(:transaction, invoice_id: @i3.id)
    @t4 = create(:transaction, invoice_id: @i4.id)
    @t5 = create(:transaction, invoice_id: @i5.id)
      require 'pry'; binding.pry
  end
  
  describe "US1 '/merchants/:merchant_id/dashboard'" do 
    it 'when I visit the merchant dashboard shows the name of the merchant' do
      visit "/merchants/#{@merchant_1.id}/dashboard" 

      expect(page).to have_content("Welcome Back, #{@merchant_1.name}")
    end
  end

  describe "US2 '/merchants/:merchant_id/dashboard'" do
    it 'merchant dashboard items links' do 
      visit "/merchants/#{@merchant_1.id}/dashboard" 

      expect(page).to have_link('My Items')
      click_link('My Items')
      expect(current_path).to eq("/merchants/#{@merchant_1.id}/items")
    end
    
    it 'merchant dashboard invoices link' do 
      visit "/merchants/#{@merchant_1.id}/dashboard" 

      expect(page).to have_link('My Invoices')
      click_link('My Invoices')
      expect(current_path).to eq("/merchants/#{@merchant_1.id}/invoices")
    end

    describe "US3 Lists Top 5 Customers" do
      it "I see the names of the top 5 customers who have conducted the largest number of successful transactions with my merchant " do
        visit "/merchants/#{@merchant_1.id}/dashboard"
        require 'pry'; binding.pry
        within("#top-customers") do 
          expect(page).to have_content("")
        end
      end
    end
  end
end

# As a merchant,
# When I visit my merchant dashboard (/merchants/:merchant_id/dashboard)
# Then I see the names of the top 5 customers
# who have conducted the largest number of successful transactions with my merchant
# And next to each customer name I see the number of successful transactions they have
# conducted with my merchant