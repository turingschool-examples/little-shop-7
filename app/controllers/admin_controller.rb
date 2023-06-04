class AdminController < ApplicationController
  def index
    @customers = Customer.top_5_customers
    @invoices = Invoice.sorted_incomplete_invoices
  end
end