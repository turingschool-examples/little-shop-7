require "rails_helper"

RSpec.describe "Admin Merchants Index", type: feature do

  it "displays the name of each merchant in the system" do 
    merch_list = create_list(:merchant, 50)

    visit "/admin/merchants"

    merch_list.each do |merch|
      expect(page).to have_content(merch.name)
    end
    save_and_open_page
  end
  
end 