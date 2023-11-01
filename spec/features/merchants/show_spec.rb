require "rails_helper"

RSpec.describe "merchant dashboard show page" do
  before :each do
    @merchant_1 = create(:merchant)
    @customer_succ_1 = create(:customer)
    @customer_succ_2 = create(:customer)
    @customer_succ_3 = create(:customer)
    @customer_succ_4 = create(:customer)
    @customer_succ_5 = create(:customer)
    @customer_fail = create(:customer)
    @invoice_succ_1 = create(:invoice, customer: @customer_succ_1)
    @invoice_succ_2 = create(:invoice, customer: @customer_succ_2)
    @invoice_succ_3 = create(:invoice, customer: @customer_succ_3)
    @invoice_succ_4 = create(:invoice, customer: @customer_succ_4)
    @invoice_succ_5 = create(:invoice, customer: @customer_succ_5)
    @invoice_fail = create(:invoice, customer: @customer_fail)
    @items = create_list(:item, 20)
    @transactions_succ_1 = create_list(:transaction, 5, result: 0, invoice: @invoice_succ_1)
    @transactions_succ_2 = create_list(:transaction, 4, result: 0, invoice: @invoice_succ_2)
    @transactions_succ_3 = create_list(:transaction, 3, result: 0, invoice: @invoice_succ_3)
    @transactions_succ_4 = create_list(:transaction, 2, result: 0, invoice: @invoice_succ_4)
    @transactions_succ_5 = create_list(:transaction, 1, result: 0, invoice: @invoice_succ_5)
    @transactions_succ_5 = create_list(:transaction, 5, result: 1, invoice: @invoice_fail)
  end

  it "shows the name of the merchant" do
    visit merchant_dashboard_path(@merchant_1)

    expect(page).to have_content(@merchant_1.name)
  end

  describe "merchant dashboard links" do
    it "shows links to merchant items index and merchant invoices index" do
      visit merchant_dashboard_path(@merchant_1)
      
      expect(page).to have_content("Items")
      expect(page).to have_content("Invoices")

      click_link("Items")

      expect(current_path).to eq("/merchants/#{@merchant_1.id}/items")
      
      visit merchant_dashboard_path(@merchant_1)

      click_link("Invoices")

      expect(current_path).to eq("/merchants/#{@merchant_1.id}/invoices")
    end
  end

  describe "merchant dashboard top customers" do
    it "shows a list of the top 5 customers and a count of their successful transactions" do
      visit merchant_dashboard_path(@merchant_1)

      expect(page).to have_content("1. #{@customer_succ_1.first_name} #{@customer_succ_1.last_name} - 5 purchases")
      expect(page).to have_content("2. #{@customer_succ_2.first_name} #{@customer_succ_2.last_name} - 4 purchases")
      expect(page).to have_content("3. #{@customer_succ_3.first_name} #{@customer_succ_3.last_name} - 3 purchases")
      expect(page).to have_content("4. #{@customer_succ_4.first_name} #{@customer_succ_4.last_name} - 2 purchases")
      expect(page).to have_content("5. #{@customer_succ_5.first_name} #{@customer_succ_5.last_name} - 1 purchases")
      expect(@customer_succ_1.last_name).to appear_before(@customer_succ_2.last_name)
      expect(page).to_not have_content(@customer_fail.first_name)
    end
  end
end