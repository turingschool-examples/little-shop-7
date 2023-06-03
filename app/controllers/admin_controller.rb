class AdminController < ApplicationController
  def index
    @customers = Customer.top_5_customers
  end
end