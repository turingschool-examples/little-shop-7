require "rails_helper"

RSpec.describe "Admin Invoices Show" do
  before(:each) do
    test_data
  end

  ## USER STORY 33
  describe 'Admin Invoices Show Page' do
    before :each do
      @test_invoice = @customer1.invoices.first
      @test_invoice.update(created_at: Time.new(2021, 12, 30))
    end
    it "when visiting show page, returns ID, status, creation date, and full name of customer on invoice" do
      visit "/admin/invoices/#{@test_invoice.id}"
      expect(page).to have_content(@test_invoice.id)
      expect(page).to have_content(@test_invoice.status)
      expect(page).to have_content("Thursday, December 30, 2021")
      expect(page).to have_content(@test_invoice.customer)
    end
  end



end