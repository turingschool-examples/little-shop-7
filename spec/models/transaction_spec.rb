require 'rails_helper'

RSpec.describe Transaction, type: :model do
  describe 'Validations' do
    it {should validate_presence_of :credit_card_number}
    it {should validate_presence_of :credit_card_expiration_date}
    it {should validate_presence_of :result}
  end

  describe 'Relationships' do
    it {should belong_to :invoice}
  end

  describe 'Enums' do
    it 'enums tests' do
      should define_enum_for(:result).with_values(["success", "failed"])
    end
  end
end
