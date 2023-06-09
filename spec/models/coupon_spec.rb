require 'rails_helper'

RSpec.describe Coupon, type: :model do
  describe "validations" do
    it { should belong_to :merchant }
  end
end
