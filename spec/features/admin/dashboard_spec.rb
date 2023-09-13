require "rails_helper"

RSpec.feature "Admin Dashboard" do 
  it "has a header" do 
    visit '/admin'

    expect(find(".header")).to have_content("Admin Dashboard")
  end
end