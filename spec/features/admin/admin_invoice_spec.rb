require "rails_helper"

RSpec.describe "Admin Invoice Page", type: :feature do
  before :each do
    @merchant_1 = Merchant.create!(name: "Bob's Burgers")
    @merchant_2 = Merchant.create!(name: "Kwik-E-Mart")
    
    @customer_1 = Customer.create!(first_name: "Marge", last_name: "Simpson")
    @customer_2 = Customer.create!(first_name: "Joe", last_name: "Swanson")
    @customer_3 = Customer.create!(first_name: "Linda", last_name: "Belcher")

    @invoice_1 = Invoice.create!(customer_id: @customer_1.id, status: 1)
    @invoice_2 = Invoice.create!(customer_id: @customer_1.id, status: 0)
    @invoice_3 = Invoice.create!(customer_id: @customer_2.id, status: 1)
    @invoice_4 = Invoice.create!(customer_id: @customer_2.id, status: 1)
    @invoice_5 = Invoice.create!(customer_id: @customer_3.id, status: 0)
    @invoice_6 = Invoice.create!(customer_id: @customer_3.id, status: 1)
  end

# US 32
  describe "As an admin when I visit the admin invoices page" do
    it "I can see a list of all invoice ids in the system" do
      visit admin_invoices_path

      Invoice.all.each do |invoice|
        expect(page).to have_link("#{invoice.id}")
      end
    end

#     As an admin,
# When I visit an admin invoice show page (/admin/invoices/:invoice_id)
# Then I see information related to that invoice including:

# Invoice id
# Invoice status
# Invoice created_at date in the format "Monday, July 18, 2019"
# Customer first and last name

    it "I can see each invoice id links to the admin invoice show page" do

      visit admin_invoices_path
      click_link(@invoice_1.id)
      
      expect(current_path).to eq(admin_invoice_path(@invoice_1))
      expect(page).to have_content(@invoice_1.id)
      expect(page).to have_content(@invoice_1.status)
      expect(page).to have_content(@invoice_1.created_at.strftime("%A, %B %d, %Y"))
      expect(page).to have_content(@customer_1.first_name)
      expect(page).to have_content(@customer_1.last_name)
      expect(page).not_to have_content(@customer_2.first_name)


    end
  end
end
