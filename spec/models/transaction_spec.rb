
require "rails_helper"

RSpec.describe Transaction, type: :model do
  describe "relationships" do
    it { should belong_to(:invoice) }
  end

  describe "validations" do
    it { should validate_length_of(:credit_card_number).is_equal_to(16) }
    # it { should validate_presence_of(:credit_card_expiration_date) }
    it { should validate_presence_of(:result) }
    it { should define_enum_for(:result) }
  end
end