class Admin::DashboardController < ApplicationController 
  def index
    @invoices = Invoice.incomplete_invoices
    @top_5_customers = Customer.top_5_spenders
  end
end