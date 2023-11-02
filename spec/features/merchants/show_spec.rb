require "rails_helper"

RSpec.describe "merchant dashboard show page" do
  before :each do
    @merchant_1 = create(:merchant)
    @customer_1 = create(:customer)
    @customer_2 = create(:customer)
    @customer_3 = create(:customer)
    @customer_4 = create(:customer)
    @customer_5 = create(:customer)
    @customer_6 = create(:customer)
    @invoice_1 = create(:invoice, customer: @customer_1)
    @invoice_2 = create(:invoice, customer: @customer_2)
    @invoice_3 = create(:invoice, customer: @customer_3)
    @invoice_4 = create(:invoice, customer: @customer_4)
    @invoice_5 = create(:invoice, customer: @customer_5)
    @invoice_6 = create(:invoice, customer: @customer_6)
    @item_1 = create(:item, merchant: @merchant_1)
    @item_2 = create(:item, merchant: @merchant_1)
    @item_3 = create(:item, merchant: @merchant_1)
    @item_4 = create(:item, merchant: @merchant_1)
    @item_5 = create(:item, merchant: @merchant_1)
    @item_6 = create(:item, merchant: @merchant_1)
    @invoice_item_1 = create(:invoice_item, invoice: @invoice_1, item: @item_1)
    @invoice_item_2 = create(:invoice_item, invoice: @invoice_2, item: @item_2)
    @invoice_item_3 = create(:invoice_item, invoice: @invoice_3, item: @item_3)
    @invoice_item_4 = create(:invoice_item, invoice: @invoice_4, item: @item_4)
    @invoice_item_5 = create(:invoice_item, invoice: @invoice_5, item: @item_5)
    @invoice_item_6 = create(:invoice_item, invoice: @invoice_6, item: @item_6)
    @transaction_1 = create(:transaction, invoice: @invoice_1, result: 0)
    @transaction_2 = create(:transaction, invoice: @invoice_2, result: 0)
    @transaction_3 = create(:transaction, invoice: @invoice_3, result: 0)
    @transaction_4 = create(:transaction, invoice: @invoice_4, result: 0)
    @transaction_5 = create(:transaction, invoice: @invoice_5, result: 0)
    @transaction_6 = create(:transaction, invoice: @invoice_6, result: 1)
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

      expect(page).to have_content("1. #{@customer_1.first_name} #{@customer_1.last_name} - 5 purchases")
      expect(page).to have_content("2. #{@customer_2.first_name} #{@customer_2.last_name} - 4 purchases")
      expect(page).to have_content("3. #{@customer_3.first_name} #{@customer_3.last_name} - 3 purchases")
      expect(page).to have_content("4. #{@customer_4.first_name} #{@customer_4.last_name} - 2 purchases")
      expect(page).to have_content("5. #{@customer_5.first_name} #{@customer_5.last_name} - 1 purchases")
      expect(@customer_1.last_name).to appear_before(@customer_2.last_name)
      expect(page).to_not have_content(@customer_6.first_name)
    end
  end
end