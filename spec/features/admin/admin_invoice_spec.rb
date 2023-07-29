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

      expect(Invoice.all.count).to eq(6) # 6 invoices created in before :each block
      
      Invoice.all.each do |invoice|
        expect(page).to have_link("#{invoice.id}")
      end
    end
  end
end
