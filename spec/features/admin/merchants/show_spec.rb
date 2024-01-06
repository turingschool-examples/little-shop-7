#When I click on the name of a merchant from the admin merchants index page (/admin/merchants),
#Then I am taken to that merchant's admin show page (/admin/merchants/:merchant_id)
#And I see the name of that merchant
require 'rails_helper'

RSpec.describe "Admin Merchant Show Page" do 
  before(:each) do 
    @merchants = create_list(:merchant, 10)
    @merchant_1 = create(:merchant)
  end
    
   it "can see the name of that merchant" do 
     visit "/admin/merchants/#{@merchant_1.id}"
     #visit admin_merchant_path(@merchant_1)

     within "admin_merchants-#{@merchant_1.id}" do
     #@merchants.each do |merchant|
      expect(page).to have_content(@merchant_1.name)
    end
  end
end