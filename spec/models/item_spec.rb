require "rails_helper"

RSpec.describe Item, type: :model do
  describe "relationships" do
    it {should belong_to(:merchant)}
    it {should have_many(:invoice_items)}
    it {should have_many(:invoices).through(:invoice_items)}
  end

  describe 'instance methods' do 
    it '#date_format' do 
      freeze_time do 
        allow(Time).to receive(:current).and_return Time.new(2000)
        item = create(:item, created_at: Time.current) 
        expect(item.date_format).to eq("Saturday, January 1, 2000")
      end
    end
  end
end
