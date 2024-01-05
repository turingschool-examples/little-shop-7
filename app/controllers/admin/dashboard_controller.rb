class Admin::DashboardController < ApplicationController 

  def index
    @customers = Customer.top_five
  end
end