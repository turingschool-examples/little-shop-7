require "rails_helper"

RSpec.describe "Invoices show page", type: :feature do
  describe "As an admin, When I visit an admin invoice show page (/admin/invoices/:invoice_id)" do
    it "Then I see information related to that invoice including:

    Invoice id
    Invoice status
    Invoice created_at date in the format 'Monday, July 18, 2019'
    Customer first and last name" do
      test_data
      visit invoice_path(@invoice_1.id)

      expect(page).to have_content("#{@invoice_1.id}")
      expect(page).to have_content("#{@invoice_1.status}")
      expect(page).to have_content("#{@invoice_1.created_at.strftime('%A, %B %d, %Y')}")
      expect(page).to have_content("#{@invoice_1.customer.first_name}")
      expect(page).to have_content("#{@invoice_1.customer.last_name}")
    end

    it "Then I see all of the items on the invoice including:

    Item name
    The quantity of the item ordered
    The price the Item sold for
    The Invoice Item status" do
      
    end
  end
end