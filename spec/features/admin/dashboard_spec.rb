require "rails_helper"

RSpec.describe "Admin Dashboard" do
  before :each do
    @customer1 = create(:customer)
    @customer2 = create(:customer)
    @customer3 = create(:customer)
    @customer4 = create(:customer)
    @customer5 = create(:customer)
  
    @test_customers = [@customer1, @customer2, @customer3, @customer4, @customer5]
  
    count = 25
    @test_customers.each do |customer|
      invoices = []
      count.times do
        invoices << create(:invoice, customer_id: customer.id)
      end
      invoices = invoices.map{|i| i.id}
      invoices.each{|id| create(:transaction, result: 1, invoice_id: id)}
      count-=1
    end

    @item1 = create(:item)
    @item2 = create(:item)
    @item3 = create(:item)
    @item4 = create(:item)
    @item5 = create(:item)

    @incomplete = create(:invoice, customer_id: @customer5.id, status: 0, created_at: Time.new(2021, 3, 9))
    @incomplete2 = create(:invoice, customer_id: @customer5.id, status: 0, created_at: Time.new(2021, 12, 5))
    @incomplete3 = create(:invoice, customer_id: @customer5.id, status: 0, created_at: Time.new(2021, 2, 4))
    @completed = create(:invoice, customer_id: @customer5.id, status: 1, created_at: Time.new(2021, 2, 4))
    @cancelled = create(:invoice, customer_id: @customer5.id, status: 2, created_at: Time.new(2021, 2, 4))

    @incomplete_results = [@incomplete, @incomplete2, @incomplete3]

    create(:invoice_item, item_id: @item1.id, invoice_id: @incomplete.id, status: 2)
    create(:invoice_item, item_id: @item2.id, invoice_id: @incomplete.id, status: 2)
    create(:invoice_item, item_id: @item3.id, invoice_id: @incomplete.id, status: 1)

    create(:invoice_item, item_id: @item1.id, invoice_id: @incomplete2.id, status: 0)
    create(:invoice_item, item_id: @item2.id, invoice_id: @incomplete2.id, status: 1)
    create(:invoice_item, item_id: @item3.id, invoice_id: @incomplete2.id, status: 0)

    create(:invoice_item, item_id: @item4.id, invoice_id: @incomplete3.id, status: 0)
    
  end

  ## USER STORY 19
  it "displays a header indicating that I am on the admin dashboard" do
    visit "/admin"
    expect(page).to have_content("Admin Dashboard")
  end

  ## USER STORY 20
  it "when visiting the admin dashboard, it has a link for the admin merchants index" do
    visit "/admin"
    click_link("Admin Merchants Index")
    expect(current_path).to eq("/admin/merchants")
  end

  it "has a link for the admin invoices index" do
    visit "/admin"
    click_link("Admin Invoices Index")
    expect(current_path).to eq("/admin/invoices")
  end

  ## USER STORY 21
  it "when visiting the dashboard, the names of the top 5 customers with the largest number of successful transactions appears" do
    visit "/admin"
    expect(page).to have_content("Top 5 Customers with the Most Successful Transactions")
    expect(@customer1.name).to appear_before(@customer2.name)
    expect(@customer2.name).to appear_before(@customer3.name)
    expect(@customer3.name).to appear_before(@customer4.name)
    expect(@customer4.name).to appear_before(@customer5.name)
  end

  ## USER STORY 22
  it "has a section for incomplete invoices with a list of IDs of all invoices not shipped" do
    visit "/admin"
    expect(page).to have_content("Incomplete Invoices")
    @incomplete_results.each do |result|
      expect(page).to have_content(result.id)
    end
  end

  it "also includes invoice ID links to the invoice admin show page" do
    visit "/admin"
    click_link "Invoice ##{@incomplete.id}"
    expect(current_path).to eq("/admin/invoices/#{@incomplete.id}")
    visit "/admin"
    click_link "Invoice ##{@incomplete2.id}"
    expect(current_path).to eq("/admin/invoices/#{@incomplete2.id}")
  end

  ## USER STORY 23
  it "in the section for Incomplete Invoices lists the date that the invoice was created" do
    visit "/admin"
    expect(page).to have_content("Incomplete Invoices")
    expect(page).to have_content("Tuesday, March 9, 2021")
    expect(page).to have_content("Sunday, December 5, 2021")
    expect(page).to have_content("Thursday, February 4, 2021")
    visit "/admin/invoices/#{@incomplete.id}"
  end

  it "is placed in order from oldest to newest" do
    visit "/admin"
    expect("Invoice ##{@incomplete3.id}").to appear_before("Invoice ##{@incomplete.id}")
    expect("Invoice ##{@incomplete.id}").to appear_before("Invoice ##{@incomplete2.id}")
  end

end
