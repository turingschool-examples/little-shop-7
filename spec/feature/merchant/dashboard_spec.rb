require 'rails_helper'

RSpec.describe 'Merchant Dashboard', type: :feature do
    before(:each) do
        @merchant_1 = Merchant.create(name: "Billy Bob")
        @merchant_2 = Merchant.create(name: "Timmy Bob")
        @merchant_3 = Merchant.create(name: "Lily Bob")
    end
    describe 'As a Merchant' do
        describe 'When I visit my merchant dashboard (/merchants/:merchant_id/dashboard)' do
            it 'Shows the name of my merchant' do
                visit merchant_dashboard_index_path(@merchant_1.id)

                within "#merchant_info" do
                    expect(page).to have_content(@merchant_1.name)
                end
            end
        end
    end
end