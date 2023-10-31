require "rails_helper"

RSpec.describe "Admin Dashboard" do
  it "has a header" do
    visit admin_path

    expect(page).to have_content("Admin Dashboard")
  end

  it "has links to admin merchants and invoices index pages" do 
    visit admin_path 

    expect(page).to have_link("Admin: Merchants")
    expect(page).to have_link("Admin: Invoices")
  end

  describe "statistics section" do 
    before :each do 
      load_test_data 
    end

    it "lists the top 5 customers" do 
      visit admin_path

      expect(page).to have_content("Top 5 Customers:")
      expect(page).to have_content(@customer_1.first_name)
      expect(page).to have_content(@customer_1.last_name)
      expect(page).to have_content(@customer_2.first_name)
      expect(page).to have_content(@customer_2.last_name)
      expect(page).to have_content(@customer_3.first_name)
      expect(page).to have_content(@customer_3.last_name)
      expect(page).to have_content(@customer_4.first_name)
      expect(page).to have_content(@customer_4.last_name)
      expect(page).to have_content(@customer_5.first_name)
      expect(page).to have_content(@customer_5.last_name)
      within "#customer-#{@customer_3.id}"
        expect(page).to have_content("4 Transactions")
      end
  end
end
