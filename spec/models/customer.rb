require 'rails_helper'

RSpec.describe Customer, type: :model do
    it 'returns name' do
      customer = build(:customer)

      expect(customer.full_name).to eq("John Doe")
    end
end