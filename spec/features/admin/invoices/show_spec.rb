require "rails_helper"

RSpec.describe "the invoice show" do
  it "shows the invoices attributes" do
    @customer_1 = Customer.create!(first_name: "Frodo", last_name: "Baggins")
    @customer_2 = Customer.create!(first_name: "Samwise", last_name: "Gamgee")

    @invoice_1k = Invoice.create!(status: "completed", customer: @customer_1, created_at: "2012-03-25 09:54:09 UTC")
    @invoice_1l = Invoice.create!(status: "in progress", customer: @customer_1)
    @invoice_2a = Invoice.create!(status: "in progress", customer: @customer_2)
    @invoice_2d = Invoice.create!(status: "completed", customer: @customer_2)
    
    visit "admin/invoices/#{@invoice_1k.id}"

    expect(page).to have_content(@invoice_1k.id)
    expect(page).to have_content("Frodo Baggins")
    expect(page).to_not have_content("Samwise")
    expect(page).to have_content("Completed")
    expect(page).to_not have_content("in progress")
    expect(page).to have_content("Sunday, March 25, 2012")
  end

  it "shows its items and details" do 
    load_test_data

    visit "admin/invoices/#{@invoice_1a.id}"

    expect(find("#ii-#{@invoice_items37.id}")).to have_content("Huskies")
    expect(find("#ii-#{@invoice_items37.id}")).to have_content(20)
    expect(find("#ii-#{@invoice_items37.id}")).to have_content(13)
    expect(find("#ii-#{@invoice_items37.id}")).to have_content("shipped")

    expect(find("#ii-#{@invoice_items38.id}")).to have_content("Gatorade")
    expect(find("#ii-#{@invoice_items38.id}")).to have_content(2)
    expect(find("#ii-#{@invoice_items38.id}")).to have_content(13)
    expect(find("#ii-#{@invoice_items38.id}")).to have_content("shipped")
  end
end