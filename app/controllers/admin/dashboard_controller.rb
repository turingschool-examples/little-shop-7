class Admin::DashboardController < ApplicationController
  layout 'admin/layouts/admin'

  def index
    @top_customers = Customer.top_customers_by_successful_transaction
  end
end
