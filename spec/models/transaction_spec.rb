require 'rails_helper'

RSpec.describe Transaction, type: :model do
  describe "relationships" do
    it { should belong_to(:invoice) }
  end

  describe "validations" do
    it { should validate_presence_of(:credit_card_number) }
    it { should validate_length_of(:credit_card_number).is_at_most(16) }
    it { should validate_presence_of(:credit_card_expiration_date) }
    it { should allow_value("02/24").for(:credit_card_expiration_date)}
    it { should_not allow_value("02/223").for(:credit_card_expiration_date).with_message("should be a MM/YY format") }
    it { should validate_presence_of(:result) }
  end
end
