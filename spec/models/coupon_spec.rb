require 'rails_helper'

RSpec.describe Coupon, type: :model do
  before(:each) do
    @merchant_1 = create(:merchant)
  end
  describe "validations" do
    subject { FactoryBot.build(:coupon, merchant_id: @merchant_1.id, status: 0, coupon_type: 0) }
    it { should belong_to :merchant }
    it { should have_many :invoices }
    it { should validate_presence_of :name }
    it { should validate_presence_of :code }
    it { should validate_uniqueness_of(:code).case_insensitive }
    it { should validate_presence_of(:status) }
    it { should validate_numericality_of(:value) }
    it { should validate_presence_of(:coupon_type) }
    it { should define_enum_for(:status).with_values([:disabled, :activated]) }
    it { should define_enum_for(:coupon_type).with_values([:percent, :dollar]) }
  end
end
