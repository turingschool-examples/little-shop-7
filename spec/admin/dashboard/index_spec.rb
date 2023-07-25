require 'rails_helper'

RSpec.describe 'Admin Dashboard', type: :feature do

  it 'exists with header' do
    visit "/admin"
    expect(page).to have_content('Admin Dashboard')
  end
end