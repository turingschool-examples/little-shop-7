require 'rails_helper'

RSpec.describe Item, type: :model do
  describe "relationships" do
    it { should belong_to(:merchant) }
    it { should have_many(:invoice_items) }
    it { should have_many(:invoices).through(:invoice_items) }
  end

  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:unit_price) }
    it { should validate_numericality_of(:unit_price).is_greater_than(0).only_integer }
  end

  describe "#change_status" do
    let(:merchant) { FactoryBot.create(:merchant) }
    let(:item) { FactoryBot.create(:item, merchant: merchant) }

    it "changes the status to disable" do
      item.change_status('Disable')
      expect(item.status).to eq("Disable")
    end

    it "changes the status to enable" do
      item.change_status('Enable')
      expect(item.status).to eq("Enable")
    end
  end
end
