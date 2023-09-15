
require 'rails_helper'

RSpec.describe 'the item edit' do
  before(:each) do 
    load_test_data
  end
  it 'can edit the item' do
    visit "/merchants/#{@merchant1.id}/items/#{@item36.id}"
    save_and_open_page
    click_link 'Edit Item'

    fill_in 'Name', with: 'Tumbler'
    click_button 'Update Item'

    expect(current_path).to eq("/merchants/#{@merchant1.id}/items")
    expect(page).to have_content('Tumbler')
  end
end
