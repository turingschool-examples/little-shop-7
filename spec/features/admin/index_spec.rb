require 'rails_helper'

RSpec.describe '/admin' do
  describe 'as an admin' do
    describe 'when I visit admin dashboard (/admin)' do
      it 'shows a header indicating that I am on the admin dashboard' do
        #US 19
        visit '/admin'

        expect(page).to have_content("Little Etsy Shop")
        expect(page).to have_content("Admin Dashboard")
        expect("Little Etsy Shop").to appear_before("Admin Dashboard")
      end

        # US 20, Admin Dashboard Links
      it "has link to admin merchants index (/admin/merchants)" do
        visit "/admin"
        
        expect(page).to have_link("Merchants")

        click_link("Merchants")

        expect(current_path).to eq("/admin/merchants")
      end

      it "has link to admin invoices index (/admin/invoices)" do
        visit "/admin"
        
        expect(page).to have_link("Invoices")

        click_link("Invoices")
        
        expect(current_path).to eq("/admin/invoices")
      end
    end
  end
end