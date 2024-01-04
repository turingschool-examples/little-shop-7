require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe "assocations" do
    it { should belong_to :customer }
    it { should have_many :transactions }
    it { should have_many :invoice_items }
    it { should have_many :items }
  end

  describe "enums" do
    it { should define_enum_for(:status).with_values([:"in progress", :completed, :cancelled]) }
  end
end
