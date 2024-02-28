require 'rails_helper'

RSpec.describe 'Admin Invoices Index', type: :feature do
  describe 'As an Admin' do
    before(:each) do
      @customer_1 = create(:customer)
      @customer_2 = create(:customer)
      @customer_3 = create(:customer)
      @customer_4 = create(:customer)
      @customer_5 = create(:customer)
      @customer_6 = create(:customer)

      @invoice_1 = create(:invoice, customer_id: @customer_1.id, created_at: "Wed, 21 Feb 2024 00:47:11.096539000 UTC +00:00")
      @invoice_2 = create(:invoice, customer_id: @customer_2.id, created_at: "Wed, 21 Feb 2024 00:47:11.096539000 UTC +00:00")
      @invoice_3 = create(:invoice, customer_id: @customer_3.id, created_at: "Wed, 21 Feb 2024 00:47:11.096539000 UTC +00:00")
      @invoice_4 = create(:invoice, customer_id: @customer_4.id, created_at: "Wed, 21 Feb 2024 00:47:11.096539000 UTC +00:00")
      @invoice_5 = create(:invoice, customer_id: @customer_5.id, created_at: "Wed, 21 Feb 2024 00:47:11.096539000 UTC +00:00")
      @invoice_6 = create(:invoice, customer_id: @customer_6.id, created_at: "Wed, 21 Feb 2024 00:47:11.096539000 UTC +00:00")
      @invoice_7 = create(:invoice, customer_id: @customer_5.id, status: 0, created_at: "Wed, 21 Feb 2024 00:47:11.096539000 UTC +00:00")
      @invoice_8 = create(:invoice, customer_id: @customer_5.id, status: 0, created_at: "Tues, 20 Feb 2024 00:47:11.096539000 UTC +00:00")
      @invoice_9 = create(:invoice, customer_id: @customer_5.id, status: 0, created_at: "Mon, 19 Feb 2024 00:47:11.096539000 UTC +00:00")
    end
    
    # User story 32. Admin Invoices Index Page
    it 'shows all invoices in the system as links to their individual show pages' do
      #   As an admin, when I visit the admin Invoices index (/admin/invoices)
      visit admin_invoices_path
      expect(page).to have_content("Invoices")
      #   Then I see a list of all Invoice ids in the system
      #   Each id links to the admin invoice show page
      within "#invoice-#{@invoice_1.id}" do
        expect(page).to have_link("Invoice ##{@invoice_1.id}", href: admin_invoice_path(@invoice_1.id))
      end

      within "#invoice-#{@invoice_2.id}" do
        expect(page).to have_link("Invoice ##{@invoice_2.id}", href: admin_invoice_path(@invoice_2.id))
      end

      within "#invoice-#{@invoice_3.id}" do
        expect(page).to have_link("Invoice ##{@invoice_3.id}", href: admin_invoice_path(@invoice_3.id))
      end

      within "#invoice-#{@invoice_4.id}" do
        expect(page).to have_link("Invoice ##{@invoice_4.id}", href: admin_invoice_path(@invoice_4.id))
      end

      within "#invoice-#{@invoice_5.id}" do
        expect(page).to have_link("Invoice ##{@invoice_5.id}", href: admin_invoice_path(@invoice_5.id))
      end

      within "#invoice-#{@invoice_6.id}" do
        expect(page).to have_link("Invoice ##{@invoice_6.id}", href: admin_invoice_path(@invoice_6.id))
      end

      within "#invoice-#{@invoice_7.id}" do
        expect(page).to have_link("Invoice ##{@invoice_7.id}", href: admin_invoice_path(@invoice_7.id))
      end

      within "#invoice-#{@invoice_8.id}" do
        expect(page).to have_link("Invoice ##{@invoice_8.id}", href: admin_invoice_path(@invoice_8.id))
      end
      
      within "#invoice-#{@invoice_9.id}" do
        expect(page).to have_link("Invoice ##{@invoice_9.id}", href: admin_invoice_path(@invoice_9.id))
      end
    end
  end
end