require "rails_helper"

RSpec.describe Customer do
  describe "factory tester" do
    let(:abel) { create(:abel) }
    it "has a first name" do
      expect(abel.first_name).to eq("Abel")
    end
  end
end