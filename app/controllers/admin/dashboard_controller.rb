class Admin::DashboardController < ApplicationController
  def index
    @customers = Customer.all
    @ordered_customers = @customers.order_customers_by_transactions
  end
end