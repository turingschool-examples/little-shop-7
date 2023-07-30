require "rails_helper"

RSpec.describe "merchant item update page" do
  before(:each) do
    @merchant = FactoryBot.create(:merchant)
    @item = FactoryBot.create(:item, merchant: @merchant)
  end

  describe "#create" do
    context 'valid form entry' do
      it "creates a new items and flashes message 'Item was created with status set to disabled!'" do
        visit merchant_items_path(@merchant)

        click_on 'Create New Item'

        fill_in "Name", with: "Ball"
        fill_in "Description", with: "Round"
        fill_in "Unit price", with: "1000"
        click_button 'Submit'

        expect(page).to have_text("Item was created with status set to disabled!")
        expect(page).to have_current_path(merchant_items_path(@merchant))
      end
    end

    context 'invalid form entry' do
      it "displays a flash message 'Failed to create item!' when data entry is invalid" do
        visit merchant_items_path(@merchant)

        click_on 'Create New Item'

        # Invalid data entry
        fill_in "Name", with: ""
        fill_in "Description", with: ""
        fill_in "Unit price", with: ""
        click_button 'Submit'

        expect(page).to have_text("Failed to create item!")
        expect(page).to have_current_path(merchant_items_path(@merchant))
      end
    end
  end
end