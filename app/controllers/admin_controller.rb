class AdminController < ApplicationController
  def index
    @customers = Customer.top_5_customers
    @invoices = Invoice.incomplete_invoices
  end
end