class Admin::DashboardController < ApplicationController 
  def index
    @top_5_customers = Customer.top_5_spenders
  end
end