require "rails_helper"

RSpec.describe "Admin Dashboard" do
  before :each do
    @customer1 = create(:customer)
    @customer2 = create(:customer)
    @customer3 = create(:customer)
    @customer4 = create(:customer)
    @customer5 = create(:customer)
    @customer6 = create(:customer)
    @customer7 = create(:customer)
    @customer8 = create(:customer)
    
    3.times do
      create(:invoice, customer_id: @customer1.id)
      create(:invoice, customer_id: @customer2.id)
      create(:invoice, customer_id: @customer3.id)
      create(:invoice, customer_id: @customer4.id)
      create(:invoice, customer_id: @customer5.id)
      create(:invoice, customer_id: @customer6.id)
      create(:invoice, customer_id: @customer7.id)
      create(:invoice, customer_id: @customer8.id)
    end

    Invoice.all.each do |i|
      create(:transaction, invoice_id: i.id)
    end

    repeat_invoices = Invoice.all.limit(12)
    repeat_invoices.all.each do |i|
      until i.transactions.pluck(:result).include?("success")
        create(:transaction, invoice_id: i.id)
      end
    end

  end

  ## USER STORY 19
  it "displays a header indicating that I am on the admin dashboard" do
    visit "/admin"
    expect(page).to have_content("Admin Dashboard")
  end

  ## USER STORY 20
  it "when visiting the admin dashboard, it has a link for the admin merchants index" do
    visit "/admin"
    click_link("Admin Merchants Index")
    expect(current_path).to eq("/admin/merchants")
  end

  it "has a link for the admin invoices index" do
    visit "/admin"
    click_link("Admin Invoices Index")
    expect(current_path).to eq("/admin/invoices")
  end

  ## USER STORY 21
  it "when visiting the dashboard, the names of the top 5 customers with the largest number of successful transactions appears" do
    visit "/admin
    # expected_results = 
    # binding.pry
    # top_5_customers = 12
  end
end
