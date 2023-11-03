require "rails_helper"

RSpec.describe "Admin Invoices Show" do
  before(:each) do
      test_data
      @test_invoice = @customer1.invoices.first
      @test_invoice.update(created_at: Time.new(2021, 12, 30))
      create(:invoice_item, item_id: @item1.id, invoice_id: @test_invoice.id, status: 2)
      create(:invoice_item, item_id: @item2.id, invoice_id: @test_invoice.id, status: 2)
      create(:invoice_item, item_id: @item3.id, invoice_id: @test_invoice.id, status: 1)
      create(:invoice_item, item_id: @item4.id, invoice_id: @test_invoice.id, status: 2)
    end

  ## USER STORY 33
    it "when visiting show page, returns ID, status, creation date, and full name of customer on invoice" do
      visit "/admin/invoices/#{@test_invoice.id}"

      expect(page).to have_content(@test_invoice.id)
      expect(page).to have_content(@test_invoice.status.capitalize)
      expect(page).to have_content("Thursday, December 30, 2021")
      expect(page).to have_content(@test_invoice.customer.name)
    end

  ## USER STORY 34
    it "has all o the items on the invoice including its name, quantity, price sold, and status" do
      visit "/admin/invoices/#{@test_invoice.id}"
      @test_invoice.invoice_items.each do |i|
        expect(page).to have_content(i.name)
        expect(page).to have_content(i.quantity)
        expect(page).to have_content(i.price)
        expect(page).to have_content(i.status)
      end
    end
  end



end