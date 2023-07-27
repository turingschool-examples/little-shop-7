require "rails_helper"

RSpec.describe Customer, type: :model do
  describe "validations" do
    it {should validate_presence_of :first_name}
    it {should validate_presence_of :last_name}
  end

  describe "relationships" do
    it { should have_many :invoices }
  end

  describe "factory_bot" do
    it "exists" do
      factory_data

      expect(@customer_1.first_name).to eq("Jimmy")
      expect(@customer_1.last_name).to eq("Pickles")
    end
  end
end
