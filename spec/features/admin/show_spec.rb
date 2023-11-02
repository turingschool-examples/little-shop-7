require "rails_helper"

RSpec.describe "admin dashboard index page" do
  before(:each) do
    @customer1 = create(:customer)
    @customer2 = create(:customer)
    @customer3 = create(:customer)
    @customer4 = create(:customer)
    @customer5 = create(:customer)
    @customer6 = create(:customer)

    @invoice1 = @customer1.invoices.create(status: 1)
    @invoice11 = @customer1.invoices.create(status: 1)
    @invoice12 = @customer1.invoices.create(status: 1)
    @invoice2 = @customer2.invoices.create(status: 1)
    @invoice22 = @customer2.invoices.create(status: 1)
    @invoice3 = @customer3.invoices.create(status: 1)
    @invoice33 = @customer3.invoices.create(status: 1)
    @invoice34 = @customer3.invoices.create(status: 1)
    @invoice35 = @customer3.invoices.create(status: 1)
    @invoice4 = @customer4.invoices.create(status: 1)
    @invoice4 = @customer4.invoices.create(status: 0)
    @invoice5 = @customer5.invoices.create(status: 1)

  end

  #user story 19
  it "Displays a admin dashboard header" do
    # visit("/admin/dashboard")
    visit admin_dashboard_path

    expect(page).to have_content("Welcome to the Admin Dashboard")
  end
  
  #user story 20
  it "has a link to the admin merchant index" do
    # visit("/admin/dashboard")
    visit admin_dashboard_path
    # expect(page).to have_link("Admin Merchants", href: "/admin/merchants")
    click_link("Admin Merchants")
    expect(current_path).to eq(admin_merchants_path)
  end

  it "has a link to the admin admin invoice index" do
    # visit("/admin/dashboard")
    visit admin_dashboard_path
    # expect(page).to have_link("Admin Invoices", href: "/admin/invoices")
    expect(page).to have_link("Admin Invoices")
    click_link("Admin Invoices")
    # expect(current_path).to eq("/admin/invoices")
    expect(current_path).to eq(admin_invoices_path)
  end

  #User story 21
  it "Displays the names of the top 5 customers" do
    visit admin_path
    expect(page).to have_content("Ilene Phannerstill, 7")
    expect(page).to have_content("Markus Grady, 6")
    expect(page).to have_content("Rollin Morar, 6")
    expect(page).to have_content("Amelia Schuster, 6")
    expect(page).to have_content("Austen Wyman, 6")
  end
end
