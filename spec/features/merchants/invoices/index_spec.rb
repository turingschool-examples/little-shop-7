require 'rails_helper'

RSpec.describe 'merchant invoices index page (/merchants/:merchant_id/invoices)' do
  before :each do
    test_data_2
    @invoices = [@invoice1, @invoice2, @invoice3]
  end

  describe 'as a visitor' do
    describe 'when I visit /merchants/:merchant_id/invoices' do
      it 'shows all the invoices that include at least on of my merchant items' do
        #US 14
        visit "/merchants/#{@merchant1.id}/invoices"
        
        @invoices.each do |invoice| 
          expect(page).to have_content(invoice.id)
        end
      end
    end
  end
end