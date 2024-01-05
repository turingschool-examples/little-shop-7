require 'rails_helper'

RSpec.describe "admin merchant index" do
  before(:each) do 
    @merchants = create_list(:merchant, 10)
  end

  it " can see the name of each merchant in the system" do
    # 24. Admin Merchants Index

    # As an admin,
    # When I visit the admin merchants index (/admin/merchants)
    visit(admin_merchants_path) 
    # Then I see the name of each merchant in the system
    @merchants.each do |merchant|
      expect(page).to have_content(merchant.name)
    end
  end
end