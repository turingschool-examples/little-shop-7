require 'rails_helper'

RSpec.describe "admin merchant index" do
  before(:each) do 
    @merchant = create(:merchant)
    @merchants = create_list(:merchant, 10)
  end

  describe "User Story 24" do
    # As an admin,
    # When I visit the admin merchants index (/admin/merchants)
    # Then I see the name of each merchant in the system
    
    it "can see the name of each merchant in the system" do

      visit(admin_merchants_path)

      @merchants.each do |merchant|
        expect(page).to have_content(merchant.name)
      end
    end
  end

  describe "User Story 27" do
    # As an admin,
    # When I visit the admin merchants index (/admin/merchants)
    # Then next to each merchant name I see a button to disable or enable that merchant.
    # When I click this button
    # Then I am redirected back to the admin merchants index
    # And I see that the merchant's status has changed
    
    it "adds an enable/disable button" do
      
    end
  end

end