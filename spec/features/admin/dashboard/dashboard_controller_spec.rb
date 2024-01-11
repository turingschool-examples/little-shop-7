require "rails_helper"

RSpec.describe "the admin dashboard show" do
  before :each do
    @customer1 = Customer.create!(first_name: "Fifth")
    @customer2 = Customer.create!(first_name: "Fourth")
    @customer3 = Customer.create!(first_name: "Third")
    @customer4 = Customer.create!(first_name: "Second")
    @customer5 = Customer.create!(first_name: "First")
    @customer6 = Customer.create!(first_name: "Bob")
    @invoice = Invoice.create!(customer: @customer1)
    Transaction.create!(invoice: @invoice, result: "success")

    2.times do
      @invoice = Invoice.create!(customer: @customer2)
      Transaction.create!(invoice: @invoice, result: "success")
    end

    3.times do
      @invoice = Invoice.create!(customer: @customer3)
      Transaction.create!(invoice: @invoice, result: "success")
    end

    4.times do
      @invoice = Invoice.create!(customer: @customer4)
      Transaction.create!(invoice: @invoice, result: "success")
    end

    5.times do
      @invoice = Invoice.create!(customer: @customer5)
      Transaction.create!(invoice: @invoice, result: "success")
    end

  #Incomplete Invoices
    @test_customer = Customer.create!(first_name: "Test", last_name: "Customer")
    @merchant = Merchant.create!(name: "Test Merchant")
    @item = Item.create!(name: "Test Item", description: "Test Description", unit_price: 100, merchant: @merchant)

    @incomplete_invoice1 = Invoice.create!(customer: @test_customer, created_at: 5.days.ago, status: "in progress")
    InvoiceItem.create!(invoice: @incomplete_invoice1, item: @item, status: "packaged")
    @incomplete_invoice2 = Invoice.create!(customer: @test_customer, created_at: 3.days.ago, status: "in progress")
    InvoiceItem.create!(invoice: @incomplete_invoice2, item: @item, status: "pending")
    @incomplete_invoice3 = Invoice.create!(customer: @test_customer, created_at: 1.day.ago, status: "in progress")
    InvoiceItem.create!(invoice: @incomplete_invoice3, item: @item, status: "pending")
    @complete_invoice = Invoice.create!(customer: @test_customer, created_at: 1.day.ago, status: "completed")
    InvoiceItem.create!(invoice: @complete_invoice, item: @item, status: "shipped")
  end

  describe "User Story 19" do
    it "displays the header" do
      visit admin_dashboard_path
      expect(page).to have_content("Admin Dashboard")
    end
  end
  
  describe "User Story 20" do
    it "has all necessary elements" do
      visit admin_dashboard_path

      expect(page).to have_selector("h1", text: "Little Esty Shop")
      expect(page).to have_selector("h1", text: "Admin Dashboard")
      expect(page).to have_link("Merchants", href: admin_merchants_path)
      expect(page).to have_link("Invoices", href: admin_invoices_path)
    end
  end

  describe "User Story 21" do
    it "displays the top customers" do
      visit admin_dashboard_path

      within(".top-customers") do
        expect(page).to have_selector("h2", text: "Top Customers")
        expect(@customer5.first_name).to appear_before(@customer4.first_name)
        expect(@customer4.first_name).to appear_before(@customer3.first_name)
        expect(@customer3.first_name).to appear_before(@customer2.first_name)
        expect(@customer2.first_name).to appear_before(@customer1.first_name)
        expect(page).to_not have_content(@customer6.first_name)
      end
    end
  end

  describe "User Story 22" do
    it "lists the IDs of incomplete invoices as links" do
      visit admin_dashboard_path

      within(".incomplete-invoices") do
        expect(page).to have_selector("h2", text: "Incomplete Invoices")
        expect(page).to have_link(@incomplete_invoice1.id.to_s)
        expect(page).to have_link(@incomplete_invoice2.id.to_s)
        expect(page).not_to have_link(@complete_invoice.id.to_s)
      end
    end
  end

  describe "User Story 23" do
    it "lists the incomplete invoices in order from oldest to newest" do
      visit admin_dashboard_path

      within(".incomplete-invoices") do
        expect(page).to have_content(@incomplete_invoice1.id)
        expect(page).to have_content(@incomplete_invoice2.id)
        expect(page).to have_content(@incomplete_invoice3.id)

        expect(@incomplete_invoice1.id.to_s).to appear_before(@incomplete_invoice2.id.to_s)
        expect(@incomplete_invoice2.id.to_s).to appear_before(@incomplete_invoice3.id.to_s)
      end
    end

    it "displays the created_at date" do
      visit admin_dashboard_path

      within(".incomplete-invoices") do
        expect(page).to have_content(@incomplete_invoice3.created_at.strftime("%A, %B %d, %Y"))
        expect(page).to have_content(@incomplete_invoice2.created_at.strftime("%A, %B %d, %Y"))
        expect(page).to have_content(@incomplete_invoice3.created_at.strftime("%A, %B %d, %Y"))
      end
    end
  end
  
end
