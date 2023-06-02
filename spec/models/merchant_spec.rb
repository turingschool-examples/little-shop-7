require 'rails_helper'

RSpec.describe Merchant, type: :model do
  context "relationships" do 
    it { should have_many :items }
    it { should have_many(:invoice_items).through(:items) }
  end

  context "validations" do
    it {should validate_presence_of(:name)}
  end

  before(:each) do 
    @merchant = create(:merchant)
  end

end


