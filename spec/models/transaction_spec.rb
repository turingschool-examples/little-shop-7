require 'rails_helper'

RSpec.describe Transaction, type: :model do
  context "relationships" do 
    it { should belong_to :invoice }
  end 
  
  context "validations" do
    it {should validate_presence_of :result }
    it {should validate_presence_of :credit_card_number }
    it {should validate_presence_of :credit_card_expiration_date }
  end

  before(:each) do
    @customer = create(:customer)
    attributes = attributes_for(:invoice_with_transaction)
    @invoice = @customer.invoices.create(attributes)
    require 'pry'; binding.pry
    transaction_attributes = attributes_for(:transaction)
    @transaction = @invoice.transactions.new(transaction_attributes)
    require 'pry'; binding.pry
  end
end
