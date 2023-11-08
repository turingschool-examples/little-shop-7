require 'rails_helper'

RSpec.describe 'merchant invoices index page (/merchants/:merchant_id/invoices)' do
  describe 'as a visitor' do
    ## USER STORY 14
    it 'shows all the invoices that include at least on of my merchant items' do
      test_data_2
      @invoices = [@invoice1, @invoice2, @invoice3]
      visit "/merchants/#{@merchant1.id}/invoices"
      
      @invoices.each do |invoice| 
        expect(page).to have_content(invoice.id)
      end
    end
  end
end