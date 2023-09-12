require "rails_helper"

RSpec.describe Customer do
  describe "factory tester" do
    let(:abel) { FactoryBot.create(:customer) }
    let(:bruce) { FactoryBot.create(:bruce) }

    it "has a first name" do
      expect(abel.first_name).to eq("Abel")
    end

    it "also has a first name" do
      expect(bruce.first_name).to eq("Bruce")
    end

  end
end