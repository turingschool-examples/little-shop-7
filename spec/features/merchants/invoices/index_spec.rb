require 'rails_helper' 

RSpec.describe "Merchants Invoices Index", type: :feature do 
  before(:each) do 
    @merchant_1 = Merchant.create(name: "Spongebob")
    @item_1 = @merchant_1.items.create(name: "Krabby Patty", description: "yummy", unit_price: "999")
    @invoice_1 = @item_1.invoices.create(status: 1)
  end

  describe "US14. When I visit my merchant's invoices index " do 
    it "then I see all of the invoices that include at least one of my merchant's items and its ID" do
      visit "/merchants/#{@merchant_1.id}/invoices"
      
      expect(page).to have_content("#{@invoice_1.id}")
    end

    it "each ID links to the merchant invoice show page" do
      visit "/merchants/#{@merchant_1.id}/invoices"
      save_and_open_page
      click_link @invoice_1.id
      expect(current_path).to eq("/merchants/#{@merchant_1.id}/#{@invoice_1.id}")
    end
  end 
end