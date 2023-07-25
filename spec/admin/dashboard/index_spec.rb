require 'rails_helper'

RSpec.describe 'Admin Dashboard', type: :feature do

  it 'exists with header' do
    visit "/admin"
    expect(page).to have_content('Admin Dashboard')
  end

  it 'has links to the admin merchants and invoices index' do
    visit "/admin"

    expect(page).to have_link("Merchants", href: "/admin/merchants")
    expect(page).to have_link("Invoices", href: "/admin/invoices")
  end
end