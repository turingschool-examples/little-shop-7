require "rails_helper"

RSpec.describe "admin dashboard index page" do
  before(:each) do
    @customer1 = create(:customer)
    @customer2 = create(:customer)
    @customer3 = create(:customer)
    @customer4 = create(:customer)
    @customer5 = create(:customer)

    @invoice1 = @customer1.invoices.create(status: 1)
    @invoice2 = @customer2.invoices.create(status: 1)
    @invoice3 = @customer3.invoices.create(status: 1)
    @invoice4 = @customer4.invoices.create(status: 1)
    @invoice5 = @customer5.invoices.create(status: 1)

  end

  it "Displays a admin dashboard header" do
    visit admin_path

    expect(page).to have_content("Welcome to the Admin Dashboard")
  end

  it "Displays the names of the top 5 customers" do
    visit admin_path
    expect(page).to have_content("Ilene Phannerstill, 7")
    expect(page).to have_content("Markus Grady, 6")
    expect(page).to have_content("Rollin Morar, 6")
    expect(page).to have_content("Amelia Schuster, 6")
    expect(page).to have_content("Austen Wyman, 6")
  end
end
