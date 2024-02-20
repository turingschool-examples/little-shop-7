require 'rails_helper'

RSpec.describe Invoice, type: :model do
  RSpec.describe Transaction, type: :model do
    describe 'Validations' do
      it {should validate_presence_of :status}
    end
  
    describe 'Relationships' do
      it {should belong_to :customer}
    end
  
    describe 'Enums' do
      xit 'enums tests' do
      end
    end
end
