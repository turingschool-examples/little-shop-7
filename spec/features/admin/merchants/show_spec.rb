#
require 'rails_helper'

RSpec.describe "Admin Merchant Show Page" do 
  before(:each) do 
    @merchant_1 = create(:merchant)
  end
    
  it "can see the name of that merchant" do 
    #USER STORY 25
    #When I click on the name of a merchant from the admin merchants index page (/admin/merchants),
    visit admin_merchants_path
    click_on(@merchant_1.name)
    #Then I am taken to that merchant's admin show page (/admin/merchants/:merchant_id)
    expect(current_path).to eq(admin_merchant_path(@merchant_1))
    #And I see the name of that merchant
    expect(page).to have_content(@merchant_1.name)
     
  end
end