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
    Transaction.create!(invoice: @invoice, result: 'success')

    2.times do
      @invoice = Invoice.create!(customer: @customer2)
      Transaction.create!(invoice: @invoice, result: 'success')
    end

    3.times do
      @invoice = Invoice.create!(customer: @customer3)
      Transaction.create!(invoice: @invoice, result: 'success')
    end

    4.times do
      @invoice = Invoice.create!(customer: @customer4)
      Transaction.create!(invoice: @invoice, result: 'success')
    end

    5.times do
      @invoice = Invoice.create!(customer: @customer5)
      Transaction.create!(invoice: @invoice, result: 'success')
    end
  end

  describe "User Story 19" do
    it "displays the header" do
      visit "/admin/"
      expect(page).to have_content("Admin Dashboard")
    end
  end
  
  describe "User Story 20" do
    it 'has all necessary elements' do
      visit admin_dashboard_path

      expect(page).to have_selector('h1', text: 'Little Esty Shop')
      expect(page).to have_selector('h1', text: 'Admin Dashboard')

      expect(page).to have_link('Merchants', href: admin_merchants_path)
      expect(page).to have_link('Invoices', href: admin_invoices_path)
    end
  end

  describe "User Story 21" do
    it 'displays the "top customers" and "incomplete invoices" dashboard sections' do

      visit admin_dashboard_path
      within('.incomplete-invoices') do
        expect(page).to have_selector('h2', text: 'Incomplete Invoices')
      end
      within('.top-customers') do
        expect(page).to have_selector('h2', text: 'Top Customers')
        expect(@customer5.first_name).to appear_before(@customer4.first_name)
        expect(@customer4.first_name).to appear_before(@customer3.first_name)
        expect(@customer3.first_name).to appear_before(@customer2.first_name)
        expect(@customer2.first_name).to appear_before(@customer1.first_name)
        expect(page).to_not have_content(@customer6.first_name)
      end
    end
  end
end
