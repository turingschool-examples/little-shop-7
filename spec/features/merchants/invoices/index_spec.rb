require 'rails_helper'

RSpec.describe 'merchant invoices index page (/merchants/:merchant_id/invoices)' do
  before :each do
    test_data_2
  end

  describe 'as a visitor' do
    describe 'when I visit /merchants/:merchant_id/invoices' do
      it 'shows all the invoices that include at least on of my merchant items' do
        #US 14
        visit "/merchants/#{@merchant1.id}/invoices"
        
        expect(page).to have_content(@)
      end
    end
  end
end