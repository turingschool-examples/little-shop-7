require 'rails_helper'

RSpec.describe 'merchant invoices index page (/merchants/:merchant_id/invoices)' do
  before :each do
    test_data_2
    @invoices = [@invoice1, @invoice2, @invoice3]
  end
  describe 'when I visit /merchants/:merchant_id/invoices' do
    it 'shows all the invoices that include at least on of my merchant items' do
      # 15. Merchant Invoice Show Page
      # As a merchant
      # When I visit my merchant's invoice show page (/merchants/:merchant_id/invoices/:invoice_id)
      # Then I see information related to that invoice including:
      # - Invoice id
      # - Invoice status
      # - Invoice created_at date in the format "Monday, July 18, 2019"
      # - Customer first and last name
      visit "/merchants/#{@merchant1.id}/invoices/#{@invoice1.id}"
        expect(page).to have_content(@invoice1.id)
        expect(page).to have_content(@invoice1.status)
        expect(page).to have_content(@invoice1.created_at.strftime('%A, %B %d, %Y'))
        expect(page).to have_content(@invoice1.customer.name)
      end
    end
  end