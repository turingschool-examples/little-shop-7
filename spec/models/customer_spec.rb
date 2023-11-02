require "rails_helper"

RSpec.describe Customer, type: :model do
  describe "relationships" do
    it { should have_many(:invoices) }
    it { should have_many(:transactions).through(:invoices) }
  end

  describe "validations" do
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
  end

  it 'creates' do
    customer = create(:customer)
    invoice = create(:invoice, customer: customer)
    transaction = create(:transaction, invoice: invoice)
      # require 'pry'; binding.pry
  end
end