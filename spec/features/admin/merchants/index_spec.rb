require "rails_helper"

RSpec.describe "admin merchants index page" do

  describe 'enable/disable merchants' do 
    let!(:little_kin_shop) { create(:merchant, name: "Dave Schools", status: 0) }
    let!(:red_roses) { create(:merchant, name: "Sunny", status: 0) }
    let!(:halloween_face) { create(:merchant, name: "JB", status: 0) }
    let!(:tall_boy) { create(:merchant) }
    let!(:arleen) { create(:merchant) }
    let!(:bust_it_big) { create(:merchant) }

    before do
      visit admin_merchants_path
    end

    it "displays all enabled merchants" do
      within(".enabled_merchants") do
        expect(page).to have_content(little_kin_shop.name)
        expect(page).to have_content(red_roses.name)
        expect(page).to have_content(halloween_face.name)
        expect(page).to_not have_content(tall_boy.name)
        expect(page).to_not have_content(arleen.name)
        expect(page).to_not have_content(bust_it_big.name)
      end
    end

    it "displays all disabled merchants" do
      within(".disabled_merchants") do
        expect(page).to_not have_content(little_kin_shop.name)
        expect(page).to_not have_content(red_roses.name)
        expect(page).to_not have_content(halloween_face.name)
        expect(page).to have_content(tall_boy.name)
        expect(page).to have_content(arleen.name)
        expect(page).to have_content(bust_it_big.name)
      end
    end

    it "provides link to a merchant's show page" do
      click_link little_kin_shop.name
      expect(current_path).to eq(admin_merchant_path(little_kin_shop))
    end

    it "provides button to disable merchant from index page" do
      within(".merchant-#{little_kin_shop.id}") do
        expect(page).to have_button("Disable")
        click_button "Disable"
        expect(current_path).to eq(admin_merchants_path)
      end
      within(".disabled_merchants") do
        expect(page).to have_content(little_kin_shop.name)
      end
    end

    it "provides button to enable merchant from index page" do
      within(".merchant-#{tall_boy.id}") do
        expect(page).to have_button("Enable")
        click_button "Enable"
        expect(current_path).to eq(admin_merchants_path)
      end
      within(".enabled_merchants") do
        expect(page).to have_content(little_kin_shop.name)
      end
    end

    it "provides link to a form for creating a new merchant" do
      within(".new_merchant") do
        expect(page).to have_link("New Merchant")
        click_link "New Merchant"
        expect(current_path).to eq(new_admin_merchant_path)
      end
    end
  end

  describe "top 5 merchants by revenue" do
    let!(:little_kin_shop) { create(:merchant, name: "jam threads") }
    let!(:jimmy) { create(:customer) }
    let!(:item_1) { create(:item, merchant_id: little_kin_shop.id) }
    let!(:invoice_1) { create(:invoice, customer_id: jimmy.id) }
    let!(:transaction_1) { create(:transaction, result: 0, invoice_id: invoice_1.id) }
    let!(:invoice_item_1) { create(:invoice_item, invoice_id: invoice_1.id, item_id: item_1.id, unit_price: 1000, quantity: 1000) }

    let!(:halloween_face) { create(:merchant,name: "costumes") }
    let!(:schools) { create(:customer) }
    let!(:item_2) { create(:item, merchant_id: halloween_face.id) }
    let!(:invoice_2) { create(:invoice, customer_id: schools.id) }
    let!(:transaction_2) { create(:transaction, result: 0, invoice_id: invoice_2.id) }
    let!(:invoice_item_2) { create(:invoice_item, invoice_id: invoice_2.id, item_id: item_2.id, unit_price: 1000, quantity: 900) }
    
    let!(:tall_boy) { create(:merchant, name: "craft delights") }
    let!(:john_bell) { create(:customer) }
    let!(:item_3) { create(:item, merchant_id: tall_boy.id) }
    let!(:invoice_3) { create(:invoice, customer_id: john_bell.id) }
    let!(:transaction_3) { create(:transaction, result: 0, invoice_id: invoice_3.id) }
    let!(:invoice_item_3) { create(:invoice_item, invoice_id: invoice_3.id, item_id: item_3.id, unit_price: 1000, quantity: 800) }

    let!(:diner) { create(:merchant, name: "unique gifts") }
    let!(:jb) { create(:customer) }
    let!(:item_4) { create(:item, merchant_id: diner.id) }
    let!(:invoice_4) { create(:invoice, customer_id: jb.id) }
    let!(:transaction_4) { create(:transaction, result: 0, invoice_id: invoice_4.id) }
    let!(:invoice_item_4) { create(:invoice_item, invoice_id: invoice_4.id, item_id: item_4.id, unit_price: 1000, quantity: 700) }
    
    let!(:bowlegged_woman) { create(:merchant, name: "lingerie shop") }
    let!(:sunny) { create(:customer) }
    let!(:item_5) { create(:item, merchant_id: bowlegged_woman.id) }
    let!(:invoice_5) { create(:invoice, customer_id: sunny.id) }
    let!(:transaction_5) { create(:transaction, result: 0, invoice_id: invoice_5.id) }
    let!(:invoice_item_5) { create(:invoice_item, invoice_id: invoice_5.id, item_id: item_5.id, unit_price: 1000, quantity: 600) }

    let!(:arleen) { create(:merchant, name: "great guitars") }
    let!(:duane) { create(:customer) }
    let!(:item_6) { create(:item, merchant_id: arleen.id) }
    let!(:invoice_6) { create(:invoice, customer_id: duane.id) }
    let!(:transaction_6) { create(:transaction, result: 0, invoice_id: invoice_6.id) }
    let!(:invoice_item_6) { create(:invoice_item, invoice_id: invoice_6.id, item_id: item_6.id, unit_price: 1000, quantity: 500) }
    
    let!(:bust_it_big) { create(:merchant, name: "swimwear") }
    let!(:jojo) { create(:customer) }
    let!(:item_7) { create(:item, merchant_id: bust_it_big.id) }
    let!(:invoice_7) { create(:invoice, customer_id: jojo.id) }
    let!(:transaction_7) { create(:transaction, result: 0, invoice_id: invoice_7.id) }
    let!(:invoice_item_7) { create(:invoice_item, invoice_id: invoice_7.id, item_id: item_7.id, unit_price: 1000, quantity: 400) }
    
    before do
      visit admin_merchants_path
    end
    
    it "displays top 5 merchants by revenue with their total revenue" do
      within(".top_5_merchants") do
        expect(page).to have_content("Top Merchants")
        expect(page).to have_link("jam threads")
        expect(little_kin_shop.name).to appear_before(halloween_face.name)
        expect(tall_boy.name).to appear_before(diner.name)
        expect(diner.name).to appear_before(bowlegged_woman.name)
        expect(page).to have_content("$1,000,000.00")
        expect(page).to have_content("$600,000.00")
        expect(page).to_not have_link("swimwear")
        click_link "jam threads"
        expect(current_path).to eq(admin_merchant_path(little_kin_shop))
      end
    end
  end

  describe "merchants best day" do
    # little_kin_shops best day was january 15, 2022
    let!(:little_kin_shop) { create(:merchant, name: "jam threads") }
    let!(:jimmy) { create(:customer) }
    let!(:item_1) { create(:item, merchant_id: little_kin_shop.id) }
    let!(:invoice_1) { create(:invoice, customer_id: jimmy.id, created_at: '2022-01-15 23:48:56 UTC') }
    let!(:invoice_11) { create(:invoice, customer_id: jimmy.id, created_at: '2023-07-29 23:48:56 UTC') }
    let!(:transaction_1) { create(:transaction, result: 0, invoice_id: invoice_1.id) }
    let!(:invoice_item_1) { create(:invoice_item, invoice_id: invoice_1.id, item_id: item_1.id, unit_price: 1000, quantity: 1000) }
    let!(:invoice_item_11) { create(:invoice_item, invoice_id: invoice_11.id, item_id: item_1.id, unit_price: 1000, quantity: 500) }
    #halloween_face best day was july 12 2023
    let!(:halloween_face) { create(:merchant,name: "costumes") }
    let!(:schools) { create(:customer) }
    let!(:item_2) { create(:item, merchant_id: halloween_face.id) }
    let!(:invoice_2) { create(:invoice, customer_id: schools.id, created_at: '2023-07-12 23:48:56 UTC') }
    let!(:invoice_12) { create(:invoice, customer_id: schools.id, created_at: '2023-07-29 23:48:56 UTC') }
    let!(:transaction_2) { create(:transaction, result: 0, invoice_id: invoice_2.id) }
    let!(:invoice_item_2) { create(:invoice_item, invoice_id: invoice_2.id, item_id: item_2.id, unit_price: 1000, quantity: 900) }
    let!(:invoice_item_12) { create(:invoice_item, invoice_id: invoice_12.id, item_id: item_2.id, unit_price: 1000, quantity: 90) }
    #tall boys best day was july 13 2023 
    let!(:tall_boy) { create(:merchant, name: "craft delights") }
    let!(:john_bell) { create(:customer) }
    let!(:item_3) { create(:item, merchant_id: tall_boy.id) }
    let!(:invoice_3) { create(:invoice, customer_id: john_bell.id, created_at: '2023-07-13 23:48:56 UTC') }
    let!(:invoice_13) { create(:invoice, customer_id: john_bell.id, created_at: '2023-07-29 23:48:56 UTC') }
    let!(:transaction_3) { create(:transaction, result: 0, invoice_id: invoice_3.id) }
    let!(:invoice_item_3) { create(:invoice_item, invoice_id: invoice_3.id, item_id: item_3.id, unit_price: 1000, quantity: 800) }
    let!(:invoice_item_13) { create(:invoice_item, invoice_id: invoice_13.id, item_id: item_3.id, unit_price: 1000, quantity: 80) }
    #diners best day was july 29 2023
    let!(:diner) { create(:merchant, name: "unique gifts") }
    let!(:jb) { create(:customer) }
    let!(:item_4) { create(:item, merchant_id: diner.id) }
    let!(:invoice_4) { create(:invoice, customer_id: jb.id, created_at: '2023-07-22 23:48:56 UTC') }
    let!(:invoice_14) { create(:invoice, customer_id: jb.id, created_at: '2023-07-29 23:48:56 UTC') }
    let!(:transaction_4) { create(:transaction, result: 0, invoice_id: invoice_4.id) }
    let!(:invoice_item_4) { create(:invoice_item, invoice_id: invoice_4.id, item_id: item_4.id, unit_price: 1000, quantity: 70) }
    let!(:invoice_item_14) { create(:invoice_item, invoice_id: invoice_14.id, item_id: item_4.id, unit_price: 1000, quantity: 700) }
    #bowlegged womans best day was july 19 2023
    let!(:bowlegged_woman) { create(:merchant, name: "lingerie shop") }
    let!(:sunny) { create(:customer) }
    let!(:item_5) { create(:item, merchant_id: bowlegged_woman.id) }
    let!(:invoice_5) { create(:invoice, customer_id: sunny.id, created_at: '2023-07-19 23:48:56 UTC') }
    let!(:invoice_15) { create(:invoice, customer_id: sunny.id, created_at: '2023-07-29 23:48:56 UTC') }
    let!(:transaction_5) { create(:transaction, result: 0, invoice_id: invoice_5.id) }
    let!(:invoice_item_5) { create(:invoice_item, invoice_id: invoice_5.id, item_id: item_5.id, unit_price: 1000, quantity: 600) }
    let!(:invoice_item_15) { create(:invoice_item, invoice_id: invoice_15.id, item_id: item_5.id, unit_price: 1000, quantity: 60) }
    #areleens best day was july 15 2023
    let!(:arleen) { create(:merchant, name: "great guitars") }
    let!(:duane) { create(:customer) }
    let!(:item_6) { create(:item, merchant_id: arleen.id) }
    let!(:invoice_6) { create(:invoice, customer_id: duane.id, created_at: '2023-07-29 23:48:56 UTC') }
    let!(:invoice_16) { create(:invoice, customer_id: duane.id, created_at: '2023-07-15 23:48:56 UTC') }
    let!(:transaction_6) { create(:transaction, result: 0, invoice_id: invoice_6.id) }
    let!(:invoice_item_6) { create(:invoice_item, invoice_id: invoice_6.id, item_id: item_6.id, unit_price: 1000, quantity: 501) }
    let!(:invoice_item_16) { create(:invoice_item, invoice_id: invoice_16.id, item_id: item_6.id, unit_price: 1000, quantity: 500) }
    #bust it bigs best day was january 11 2023
    let!(:bust_it_big) { create(:merchant, name: "swimwear") }
    let!(:jojo) { create(:customer) }
    let!(:item_7) { create(:item, merchant_id: bust_it_big.id) }
    let!(:invoice_7) { create(:invoice, customer_id: jojo.id) }
    let!(:invoice_17) { create(:invoice, customer_id: jojo.id) }
    let!(:transaction_7) { create(:transaction, result: 0, invoice_id: invoice_7.id) }
    let!(:invoice_item_7) { create(:invoice_item, invoice_id: invoice_7.id, item_id: item_7.id, unit_price: 1000, quantity: 400, created_at: '11 Jan 2023') }
    let!(:invoice_item_17) { create(:invoice_item, invoice_id: invoice_17.id, item_id: item_7.id, unit_price: 1000, quantity: 40, created_at: '06 Feb 2023') }
    
    before do
      visit admin_merchants_path
    end

    it "displays best day for top 5 merchants" do
      within(".top_5_merchants") do         
        expect(page).to have_content("Top Day: 2022-01-15 23:48:56 UTC")
        expect(page).to have_content("Top Day: 2023-07-12 23:48:56 UTC")
        expect(page).to have_content("Top Day: 2023-07-13 23:48:56 UTC")
        expect(page).to have_content("Top Day: 2023-07-19 23:48:56 UTC")
        expect(page).to have_content("Top Day: 2023-07-19 23:48:56 UTC")
      end
    end

  end
end