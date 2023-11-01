require "rails_helper"

RSpec.describe Customer, type: :model do
  describe "relationships" do
    it { should have_many(:invoices) }
    it { should have_many(:transactions).through(:invoices) }
  end

  # describe "validations" do
  #   it { should validate_presence_of(:customer_id) }
  #   it { should validate_presence_of(:status) }
  # end

end