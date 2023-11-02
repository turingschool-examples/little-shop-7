require "rails_helper"

RSpec.describe Customer, type: :model do
  before :each do
    @customer = create(:customer)
    # @item_1 = create(:item)
  end

  describe "relationships" do
    it { should have_many(:invoices)}
    it { should have_many(:transactions).through(:invoices) }
    it { should have_many(:invoice_items).through(:invoices) }
    it { should have_many(:items).through(:invoice_items) }
    it { should have_many(:merchants).through(:items) }
  end

  describe "validations" do
    it {should validate_presence_of(:first_name)}
    it {should validate_presence_of(:last_name)}
  end

  describe "instance methods" do
    describe "#full_name" do
      it "can return the full name of the customer'" do
        expect(@customer.full_name).to eq("#{@customer.first_name} #{@customer.last_name}")
      end
    end
  end
end