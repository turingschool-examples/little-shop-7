require 'rails_helper'

RSpec.describe Customer, type: :model do
  describe "relationships" do
    it { should have_many :invoices }
  end

  before :each do 
    10.times do 
      create(:customer)
    end
  end

  it do 

  end
end