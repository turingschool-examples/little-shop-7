require "rails_helper"

RSpec.describe "the admin index" do
  it "displays a header at the top of the dashboard" do
    
    visit "/admin"

    expect(page).to have_content("Admin Dashboard")
  
  end

  it "has links to the admin merchant's index and the admin invoices index" do
    visit "/admin"
    
    within("#admin_merchants_index") do
      expect(page).to have_link("Merchants")
    end
    
    within("#admin_invoices_index") do
      expect(page).to have_link("Invoices")
    end
  end

  it "displays the top 5 customers" do
    customer_1 = create(:customer)
    customer_2 = create(:customer)
    customer_3 = create(:customer)
    customer_4 = create(:customer)
    customer_5 = create(:customer)
    customer_6 = create(:customer)
    

    invoice_1 = create(:invoice, customer: customer_1)
    invoice_2 = create(:invoice, customer: customer_2)
    invoice_3 = create(:invoice, customer: customer_3)
    invoice_4 = create(:invoice, customer: customer_4)
    invoice_5 = create(:invoice, customer: customer_5)
    invoice_6 = create(:invoice, customer: customer_6)

    transactions_for_invoice_1 = create_list(:transactions, 4, invoice: invoice_1)
    transactions_for_invoice_2 = create_list(:transactions, 5, invoice: invoice_2)
    transactions_for_invoice_3 = create_list(:transactions, 6, invoice: invoice_3)
    transactions_for_invoice_4 = create_list(:transactions, 1, invoice: invoice_4)
    transactions_for_invoice_5 = create_list(:transactions, 2, invoice: invoice_5)
    transactions_for_invoice_6 = create_list(:transactions, 3, invoice: invoice_6)
    
    visit "/admin"

    expect(customer_3).to appear_before(customer_2)
    expect(customer_2).to appear_before(customer_1)
    expect(customer_1).to appear_before(customer_6)
    expect(customer_6).to appear_before(customer_5)
    expect(page).to have_content(customer_5)
    expect(page).not_to have_content(customer_4)
  end
end