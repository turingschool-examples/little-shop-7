
require 'rails_helper' 

RSpec.describe 'Merchant Items Show Page', type: :feature do 
  before(:each) do 
    @betty = create(:merchant)
    @joshy = create(:merchant)
    @item_1 = create(:item,unit_price: 2222, merchant_id: @betty.id)
    @item_2 = create(:item, merchant_id: @betty.id)
    @item_3 = create(:item, merchant_id: @betty.id)
    @item_4 = create(:item, unit_price: 7890, merchant_id: @joshy.id)
  end
  
  describe '/merchants/:merchant_id/items/:item_id' do 
    it 'shows items attributes on view page' do
      visit  merchant_item_path(@betty, @item_1)
      within("h1") do
        expect(page).to have_content("#{@betty.name}'s #{@item_1.name} Show Page") 
      end
      expect(page).to have_content(@item_1.name) 
      expect(page).to have_content("Description: #{@item_1.description}") 
      expect(page).to have_content("Current Selling Price: $22.22") 
      expect(page).to_not have_content(@item_2.name) 
      expect(page).to_not have_content(@item_3.name) 
      expect(page).to_not have_content(@item_4.name) 
    end
    
    it 'if item unit price ends in zero, unit price is still formatted' do 
      visit  merchant_item_path(@joshy, @item_4)
      expect(page).to have_content("Current Selling Price: $78.90")
    end
  end
end