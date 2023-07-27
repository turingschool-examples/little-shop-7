require 'rails_helper'

RSpec.describe Customer, type: :model do 
  describe "relationships" do
    it {should have_many :invoices}
    it {should have_many(:transactions).through(:invoices)}
    it {should have_many(:items).through(:invoices)}
  end


  describe "instance methods" do 
    describe "#full_name" do 
      it " give the first and last name" do 
        customer1 = Customer.create!(first_name:"Paul", last_name: "McCartney")

        expect(customer1.full_name).to eq("Paul McCartney")
      end
    end
  end
end