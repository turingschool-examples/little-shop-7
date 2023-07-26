require 'rails_helper' 

RSpec.describe "merchant dashboard", type: :feature do
  before(:each) do
    @merchant_1 = Merchant.create!(name: "Schroeder-Jerde", status: nil)
  end

  describe "as a merchant" do
    describe "when I visit my merchant dashboard" do
      it "displays the name of my merchant" do
        visit merchant_dashboards_path(@merchant_1)

        expect(page).to have_content(@merchant_1.name)
      end
    end
  end
end