require "rails_helper"

RSpec.describe "Admin Invoices Index" do
  before(:each) do
    test_data
  end

  ## USER STORY 32
  describe 'Admin Invoices Index Page' do
    before :each do
      @testing_invoices = @customer1.invoices.limit(5)
    end

    it 'when visiting the invoice index page, shows all invoice ids in the system' do
      visit "/admin/invoices"
      @testing_invoices.each do |i|
        expect(page).to have_content(i.id)
      end
    end

    it "has a link for each id listed that directs to that invoice show page" do
      visit "/admin/invoices"
      @testing_invoices.each do |i|
        click_link "Invoice ##{i.id}"
        expect(current_path).to eq("/admin/invoices/#{i.id}")
        visit "/admin/invoices"
      end
    end
  end

end