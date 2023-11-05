require "rails_helper"

RSpec.describe "merchant items index page" do
  before :each do
    @merchant_1 = create(:merchant)
    @merchant_2 = create(:merchant)
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
    @item_7 = create(:item, merchant: @merchant_2)
    @item_8 = create(:item, merchant: @merchant_2, status: 1)
    @invoice_item_1 = create(:invoice_item, invoice: @invoice_1, item: @item_1, unit_price: 50000)
    @invoice_item_2 = create(:invoice_item, invoice: @invoice_2, item: @item_2, unit_price: 40000)
    @invoice_item_3 = create(:invoice_item, invoice: @invoice_3, item: @item_3, unit_price: 30000)
    @invoice_item_4 = create(:invoice_item, invoice: @invoice_4, item: @item_4, unit_price: 20000)
    @invoice_item_5 = create(:invoice_item, invoice: @invoice_5, item: @item_5, unit_price: 10000)
    @invoice_item_6 = create(:invoice_item, invoice: @invoice_6, item: @item_6, unit_price: 6000000, status: 2)
    @transaction_1 = create_list(:transaction, 5, invoice: @invoice_1, result: 0)
    @transaction_2 = create_list(:transaction, 4, invoice: @invoice_2, result: 0)
    @transaction_3 = create_list(:transaction, 3, invoice: @invoice_3, result: 0)
    @transaction_4 = create_list(:transaction, 2, invoice: @invoice_4, result: 0)
    @transaction_5 = create_list(:transaction, 1, invoice: @invoice_5, result: 0)
    @transaction_6 = create(:transaction, invoice: @invoice_6, result: 1)
  end

  # US6
  it "shows the names of all of this merchant's items" do
    visit merchant_items_path(@merchant_1)

    expect(page).to have_content(@item_1.name)
    expect(page).to have_content(@item_2.name)
    expect(page).to have_content(@item_3.name)
    expect(page).to have_content(@item_4.name)
    expect(page).to have_content(@item_5.name)
  end

  # US6
  it "does not show the names of items belonging to other merchants" do
    visit merchant_items_path(@merchant_1)
    
    expect(page).to_not have_content(@item_7.name)
  end

  # US7
  it "item names link to merchant item show page" do
    visit merchant_items_path(@merchant_1)

    click_link "#{@item_1.name}"

    expect(current_path).to eq(merchant_item_path(@merchant_1, @item_1))
  end

  # US9
  it "has buttons to enable or disable for each item" do
    visit merchant_items_path(@merchant_1)

    expect(page).to have_button("Disable Item")
  end

  # US9
  it "enable button changes item status and redirects back" do
    visit merchant_items_path(@merchant_2)

    within("##{@item_8.id}") do
      click_button "Enable Item"
    end

    expect(current_path).to eq(merchant_items_path(@merchant_2))
    within("##{@item_8.id}") do
      expect(page).to have_button("Disable Item")
    end
  end

  # US9
  it "disable button changes item status and redirects back" do
    visit merchant_items_path(@merchant_1)

    within("##{@item_1.id}") do
      click_button "Disable Item"
    end

    expect(current_path).to eq(merchant_items_path(@merchant_1))
    within("##{@item_1.id}") do
      expect(page).to have_button("Enable Item")
    end
  end

  # US10
  it "enabled items are listen in a separate section" do
    visit merchant_items_path(@merchant_1)

    within("#enabled-items") do
      expect(page).to have_content(@item_1.name)
      expect(page).to have_content(@item_2.name)
      expect(page).to have_content(@item_3.name)
      expect(page).to have_content(@item_4.name)
      expect(page).to have_content(@item_5.name)
    end
  end

  # US10
  it "disabled items are listen in a separate section" do
    visit merchant_items_path(@merchant_2)

    within("#disabled-items") do
      expect(page).to have_content(@item_8.name)
    end

    within("#enabled-items") do
      expect(page).to have_content(@item_7.name)
    end
  end

  # US11
  it "has a link to create a new item" do
    visit merchant_items_path(@merchant_1)

    expect(page).to have_link("Add Item")

    click_link "Add Item"

    expect(current_path).to eq(new_merchant_item_path(@merchant_1))
  end

  # US12
  it "displays the top 5 items for this merchant, ordered by total revenue" do
    visit merchant_items_path(@merchant_1)

    within("#top-5-items") do
      expect(page).to have_content("Top 5 Items: #{@item_1.name} #{@item_2.name} #{@item_3.name} #{@item_4.name} #{@item_5.name}")
    end
  end

  # US12
  it "top 5 item names link to that item's show page" do
    visit merchant_items_path(@merchant_1)

    within("#top-5-items") do
      click_link "#{@item_1.name}"
    end

    expect(current_path).to eq(merchant_item_path(@merchant_1, @item_1))
  end

  # US12
  it "top 5 items lists total revenue next to each item name" do
    visit merchant_items_path(@merchant_1)

    within("#top-5-items") do
      expect(page).to have_content("#{@item_1.name}: $250.00")
    end
  end
end