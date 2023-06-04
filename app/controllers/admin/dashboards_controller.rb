class Admin::DashboardsController < ApplicationController
  def welcome
    @customers = Customer.all
  end

end