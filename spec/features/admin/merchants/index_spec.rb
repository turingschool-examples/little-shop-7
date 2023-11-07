require "rails_helper"

RSpec.describe "the merchants index" do
  describe "US24" do
    it "lists all merchants in the system" do
      merchant1 = Merchant.create!(name: "Sooyung LLC")
      merchant2 = Merchant.create!(name: "Joseph LLC")
      merchant3 = Merchant.create!(name: "Anthea LLC")
      merchant4 = Merchant.create!(name: "Nathan LLC")

      visit "/admin/merchants"

      expect(page).to have_content(merchant1.name)
      expect(page).to have_content(merchant2.name)
      expect(page).to have_content(merchant3.name)
      expect(page).to have_content(merchant4.name)
    end
  end

  it "has buttons to enable or disable each merchant and disables when 'Disable' is clicked" do
    merchant1 = Merchant.create!(name: "Sooyung LLC")

    visit "/admin/merchants"

    expect(page).to have_link(merchant1.name)
    expect(merchant1.enabled).to be(true)
    expect(page).to have_button("Disable")
    click_button("Disable")
    expect(page).to have_current_path("/admin/merchants")

    merchant1.reload
    expect(merchant1.enabled).to be(false)
  end

  describe "US27" do
    it "has buttons to enable or disable each merchant and enables when 'Enable' is clicked" do
      merchant1 = Merchant.create!(name: "Sooyung LLC", enabled: false)

      visit "/admin/merchants"

      expect(page).to have_link(merchant1.name)
      expect(merchant1.enabled).to be(false)
      expect(page).to have_button("Enable")
      click_button("Enable")
      expect(page).to have_current_path("/admin/merchants")

      merchant1.reload
      expect(merchant1.enabled).to be(true)
    end
  end

  describe "US28" do
    it "checks to see if there are the sections of 'Enabled Merchants' and 'Disabled Merchants'" do
      visit "/admin/merchants"

      expect(page).to have_content("Enabled Merchants")
      expect(page).to have_content("Disabled Merchants")
    end
  end

  describe "US29" do
    before(:each) do
      @merchant1 = Merchant.create!(name: "Sooyung LLC")
      @merchant2 = Merchant.create!(name: "Joseph LLC")
      @merchant3 = Merchant.create!(name: "Anthea LLC")
      @merchant4 = Merchant.create!(name: "Nathan LLC")
    end
    it "has a link to create a new merchant" do
      visit "admin/merchants"
      expect(page).to have_link("Create a new merchant")
      expect(Merchant.count).to eq(4)
    end

    it "takes me to the create page when I click the link" do
      visit "/admin/merchants"
      expect(page).to have_link("Create a new merchant")
      click_link("Create a new merchant")
      expect(page).to have_current_path("/admin/merchants/new")
    end
  end
  
  ## EXTENSION 1-2 (ADMIN MERCHANT)
  describe 'Sorting Option on Admin Merchant Index' do
    before :each do
      merchant1 = Merchant.create!(name: "Sooyung LLC", created_at: Time.new(2010, 10, 2))
      merchant2 = Merchant.create!(name: "Joseph LLC", created_at: Time.new(2011, 10, 2))
      merchant3 = Merchant.create!(name: "Anthea LLC", created_at: Time.new(2012, 10, 2))
      merchant4 = Merchant.create!(name: "Nathan LLC", created_at: Time.new(2013, 10, 2))
    end

    it "when visiting the index, have two button options for sorting" do
      visit "/admin/merchants"
      expect(page).to have_button("Sort Alphabetically, A-Z")
      expect(page).to have_button("Sort by Date, Newest-Oldest")      
    end

    it "can sort alphabetically A-Z" do
      visit "/admin/merchants"
      click_button "Sort Alphabetically, A-Z"
      expect(current_path).to eq("/admin/merchants")
      
      alphabetical = Merchant.all.sort
      count = alphabetical.length
      check = alphabetical.first.id.to_s
      num = 1
      count-1.times do
        compare = alphabetical[num].id.to_s
        expect(check).to appear_before(compare)
        num+=1
      end
    end

    it "can sort by date newest to oldest" do
      visit "/admin/merchants"
      click_button "Sort by Date, Newest-Oldest"
      expect(current_path).to eq("/admin/merchants")

      order = Merchant.all.sort_by{|i| -i.created_at.to_i}
      count = order.length
      check = order.first.id.to_s
      num = 1
      count-1.times do
        compare = order[num].id.to_s
        expect(check).to appear_before(compare)
        num+=1
      end
    end

  end
end

