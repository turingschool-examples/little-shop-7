require "rails_helper"

RSpec.describe "/admin" do
  before(:each) do
    @merchant_1 = create(:merchant)
    @item_1 = create(:item, merchant_id: @merchant_1.id)
    @item_2 = create(:item, merchant_id: @merchant_1.id)
    @item_3 = create(:item, merchant_id: @merchant_1.id)

    @merchant_2 = create(:merchant)
    @item_4 = create(:item, merchant_id: @merchant_2.id)
    @item_5 = create(:item, merchant_id: @merchant_2.id)
    @item_6 = create(:item, merchant_id: @merchant_2.id)

    @merchant_3 = create(:merchant)
    @item_7 = create(:item, merchant_id: @merchant_3.id)
    @item_8 = create(:item, merchant_id: @merchant_3.id)
    @item_9 = create(:item, merchant_id: @merchant_3.id)

    @customer_1 = create(:customer)
    @customer_2 = create(:customer)
    @customer_3 = create(:customer)

    @invoice_1 = create(:invoice, customer_id: @customer_1.id, status: 0)
    @invoice_2 = create(:invoice, customer_id: @customer_1.id, status: 1)
    @invoice_3 = create(:invoice, customer_id: @customer_1.id, status: 2)

    @invoice_4 = create(:invoice, customer_id: @customer_2.id, status: 0)
    @invoice_5 = create(:invoice, customer_id: @customer_2.id, status: 1)
    @invoice_6 = create(:invoice, customer_id: @customer_2.id, status: 2)

    @invoice_7 = create(:invoice, customer_id: @customer_3.id, status: 0)
    @invoice_8 = create(:invoice, customer_id: @customer_3.id, status: 1)
    @invoice_9 = create(:invoice, customer_id: @customer_3.id, status: 2)

    @invoice_item_1 = create(:invoice_item, invoice: @invoice_1, item: @item_1)
    @invoice_item_2 = create(:invoice_item, invoice: @invoice_2, item: @item_2)
    @invoice_item_3 = create(:invoice_item, invoice: @invoice_3, item: @item_3)
    @invoice_item_4 = create(:invoice_item, invoice: @invoice_4, item: @item_4)
    @invoice_item_5 = create(:invoice_item, invoice: @invoice_5, item: @item_5)
    @invoice_item_6 = create(:invoice_item, invoice: @invoice_6, item: @item_6)
    @invoice_item_7 = create(:invoice_item, invoice: @invoice_7, item: @item_7)
    @invoice_item_8 = create(:invoice_item, invoice: @invoice_8, item: @item_8)
    @invoice_item_9 = create(:invoice_item, invoice: @invoice_9, item: @item_9)
    
    @transaction_1 = create(:transaction, invoice: @invoice_1)
    @transaction_2 = create(:transaction, invoice: @invoice_2)
    @transaction_3 = create(:transaction, invoice: @invoice_3)
    @transaction_4 = create(:transaction, invoice: @invoice_4)
    @transaction_5 = create(:transaction, invoice: @invoice_5)
    @transaction_6 = create(:transaction, invoice: @invoice_6)
    @transaction_7 = create(:transaction, invoice: @invoice_7)
    @transaction_8 = create(:transaction, invoice: @invoice_8)
    @transaction_9 = create(:transaction, invoice: @invoice_9)
  end

  describe "As an admin" do
    describe "when I visit the admin dashboard page " do
      it "displays a header to inidicate the user is on the 'admin dashboard' page" do
        visit "/admin"
        expect(current_path).to eq("/admin")
        

        # within ".admin_dashboard_header" do
        #   expect(page).to have_content("Admin Dashboard")
        # end
      end
    end

    # it "displays a link to each of the merchants on the admin merchants index page" do
    #   visit "/admin/merchants"

    #   # within ".admin_merchants" do
    #   #   expect(page).to have_link("#{merchant_1.name}")
    #   #   expect(page).to have_link("#{merchant_2.name}")
    #   #   expect(page).to have_link("#{merchant_3.name}")

    #   #   click_link("#{merchant_2.name}")
    #   # end

    #   # expect(current_path).to eq("/admin/merchants/#{merchant_2.id}")
    # end
  end
end