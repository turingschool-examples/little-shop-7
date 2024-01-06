class Admin::DashboardController < ApplicationController 

  def index
    @customers = Customer.top_five
    @invoice_items = InvoiceItem.incomplete_invoices 
  end
end