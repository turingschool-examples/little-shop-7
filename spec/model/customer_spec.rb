require "rails_helper"

Rspec.describe Customer, type: :model do
  describe "relationships" do
    it { should have_many(:invoices)}
  end
end