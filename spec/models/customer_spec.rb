require "rails_helper"

# RSpec.describe Customer do
RSpec.describe Customer, type: :model do
    describe "relationships" do
      it { should have_many :invoices }
    end
  end
  # describe "factory tester" do
  #   let(:abel) { FactoryBot.create(:customer) }
  #   let(:bruce) { FactoryBot.create(:bruce) }
  #   let(:first) { FactoryBot.create(:invoice)}

  #   it "has a first name" do
  #     expect(abel.first_name).to eq("Abel")
  #   end

  #   it "also has a first name" do
  #     expect(bruce.first_name).to eq("Bruce")
  #   end

  #   it "has invoices" do
  #     expect(bruce.invoices).to eq(binding.pry)
  #   end

  # end
# end