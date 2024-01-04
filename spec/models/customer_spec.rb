require 'rails_helper'

RSpec.describe Customer, type: :model do
  describe "assocations" do
    it { should have_many :invoices }
  end
end
