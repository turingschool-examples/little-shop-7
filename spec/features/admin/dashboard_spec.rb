require "rails_helper"

RSpec.feature "Admin Dashboard" do 
  it "has a header" do 
    visit '/admin'

    expect(find(".header")).to have_content("Admin Dashboard")
  end

  it "has link to the admin merchants index" do 
    visit '/admin'

    expect(page).to have_link("Admin: All Merchants")
    expect(page).to have_link("Admin: All Invoices")
  end

  describe "advanced features" do
    before(:each) do
      load_test_data
    end

    it "has the top five customers" do
      visit '/admin'
      save_and_open_page
      expect(page).to have_content(@customer_1.first_name)
      expect(page).to have_content(@customer_1.last_name)
      expect(page).to have_content(@customer_3.first_name)
      expect(page).to have_content(@customer_3.last_name)
      expect(page).to have_content(@customer_2.first_name)
      expect(page).to have_content(@customer_2.last_name)
      expect(page).to have_content(@customer_4.first_name)
      expect(page).to have_content(@customer_4.last_name)
      expect(page).to have_content(@customer_5.first_name)
      expect(page).to have_content(@customer_5.last_name)
    end
  end
end