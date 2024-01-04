require 'rails_helper'

RSpec.describe InvoiceItem, type: :model do
  describe "assocations" do
    it { should belong_to :item }
    it { should belong_to :invoice }
  end

  describe "enums" do
    it { should define_enum_for(:status).with_values([:pending, :packaged, :shipped]) }
  end
end
