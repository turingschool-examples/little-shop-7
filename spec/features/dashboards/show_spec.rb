require 'rails_helper'

RSpec.describe 'Merchant Dashboard Show Page' do
  let(:merchant) { FactoryBot.create(:merchant) }
  let(:item) { FactoryBot.create(:item, merchant: merchant) }
  let(:top_customers) { FactoryBot.create_list(:customer, 5) }
  let(:customers) { FactoryBot.create_list(:customer, 5) }

  before do
    top_customers.each do |customer|
      invoice = FactoryBot.create(:invoice, customer: customer)
      invoice.items = [item]
      FactoryBot.create_list(:transaction, Random.rand(2..5), invoice: invoice)
      invoice.save!
    end
    customers.each do |customer|
      invoice = FactoryBot.create(:invoice, customer: customer)
      invoice.items = [item]
      FactoryBot.create_list(:transaction, 1, invoice: invoice)
      invoice.save!
    end
  end
  # let!(:merchant) { Merchant.create!(name: "Schroeder-Jerde") }

  # let!(:customer_1) { Customer.create!(first_name: "Joey", last_name: "Ondricka") }
  # let!(:customer_2) { Customer.create!(first_name: "Cecelia", last_name: "Osinski")}
  # let!(:customer_3) { Customer.create!(first_name: "Mariah", last_name: "Toy") }
  # let!(:customer_4) { Customer.create!(first_name: "Leanne", last_name: "Braun") }
  # let!(:customer_5) { Customer.create!(first_name: "Sylvester", last_name: "Nader") }
  # let!(:customer_6) { Customer.create!(first_name: "Heber", last_name: "Kuhn") }
  # let!(:item_1) { merchant.items.create!() }
  # let!(:invoice_1) { customer_1.invoices.create!(status: "completed") }
  # let!(:invoice_2) { customer_1.invoices.create!(status: "completed") }
  # let!(:invoice_3) { customer_1.invoices.create!(status: "completed") }
  # let!(:invoice_4) { customer_2.invoices.create!(status: "completed") }
  # let!(:invoice_5) { customer_2.invoices.create!(status: "completed") }
  # let!(:invoice_6) { customer_3.invoices.create!(status: "completed") }
  # let!(:invoice_7) { customer_4.invoices.create!(status: "completed") }
  # let!(:invoice_8) { customer_4.invoices.create!(status: "completed") }
  # let!(:invoice_9) { customer_5.invoices.create!(status: "completed") }
  # let!(:invoice_10) { customer_5.invoices.create!(status: "completed") }
  # let!(:invoice_11) { customer_6.invoices.create!(status: "cancelled") }

  # let!(:transaction_1) { invoice_1.transactions.create!(credit_card_number: "4654405418249632", credit_card_expiration_date: "04/27", result: "failed") }
  # let!(:transaction_2) { invoice_1.transactions.create!(credit_card_number: "4654405418249632", credit_card_expiration_date: "04/27", result: "success") }
  # let!(:transaction_3) { invoice_2.transactions.create!(credit_card_number: "4654405418249632", credit_card_expiration_date: "04/27", result: "success") }
  # let!(:transaction_4) { invoice_3.transactions.create!(credit_card_number: "4654405418249632", credit_card_expiration_date: "04/27", result: "success") }
  # let!(:transaction_5) { invoice_4.transactions.create!(credit_card_number: "4580251236515201", credit_card_expiration_date: "10/27", result: "success") }
  # let!(:transaction_6) { invoice_5.transactions.create!(credit_card_number: "4580251236515201", credit_card_expiration_date: "10/27", result: "success") }
  # let!(:transaction_7) { invoice_6.transactions.create!(credit_card_number: "4354495077693036", credit_card_expiration_date: "06/27", result: "success") }
  # let!(:transaction_8) { invoice_7.transactions.create!(credit_card_number: "4515551623735607", credit_card_expiration_date: "04/28", result: "success") }
  # let!(:transaction_9) { invoice_8.transactions.create!(credit_card_number: "4515551623735607", credit_card_expiration_date: "04/28", result: "failed") }
  # let!(:transaction_10) { invoice_8.transactions.create!(credit_card_number: "4844518708741275", credit_card_expiration_date: "08/27", result: "success") }
  # let!(:transaction_11) { invoice_9.transactions.create!(credit_card_number: "4203696133194408", credit_card_expiration_date: "12/26", result: "success") }
  # let!(:transaction_12) { invoice_10.transactions.create!(credit_card_number: "4801647818676136", credit_card_expiration_date: "09/25", result: "success") }
  # let!(:transaction_13) { invoice_11.transactions.create!(credit_card_number: "4540842003561938", credit_card_expiration_date: "01/26", result: "failed") }

  describe "As a merchant" do
    it "shows the name of my merchant" do
      visit merchant_dashboard_path(merchant_id: merchant.id)

      expect(page).to have_content(merchant.name)
    end

    it "shows link to my merchant item index and merchant invoices index" do
      visit merchant_dashboard_path(merchant_id: merchant.id)

      expect(page).to have_link("My Items", href: merchant_items_path(merchant))
      expect(page).to have_link("My Invoices", href: merchant_invoices_path(merchant))
    end

    it "shows the names of the top 5 customers and the number of successful transactions with my merchant" do
      visit merchant_dashboard_path(merchant_id: merchant.id)

      top_customers.each do |top_customer|
        expect(page).to have_content("#{top_customer.first_name} #{top_customer.last_name} #{top_customer.transactions.count}")
      end
    end
  end
end
