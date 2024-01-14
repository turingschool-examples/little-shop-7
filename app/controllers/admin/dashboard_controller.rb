class Admin::DashboardController < ApplicationController
  layout "admin/layouts/admin"

  def index
    @top_customers = Customer.top_customers_by_successful_transaction
    @incomplete_invoices = Invoice.incomplete_invoices
  end
end
