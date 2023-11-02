require 'rails_helper'

RSpec.describe 'merchant items index page' do
  before :each do
    @merchant1 = create(:merchant)
    @merchant2 = create(:merchant)

    @item1 = create(:item, merchant_id: @merchant1.id)
    @item2 = create(:item, merchant_id: @merchant1.id)
    @item3 = create(:item, merchant_id: @merchant1.id)
    @item4 = create(:item, merchant_id: @merchant2.id)
  end

  describe 'as a merchant' do
    describe 'when I visit merchant items index page /merchants/:merchant_id/items' do
      it 'shows the list of items name' do
        #US 6
        visit "/merchants/#{@merchant1.id}/items"
        expect(page).to have_content(@item1.name)
        expect(page).to have_content(@item2.name)
        expect(page).to have_content(@item3.name)
        expect(page).to_not have_content(@item4.name)
        save_and_open_page
      end
    end
  end
end