class Admins::InvoicesController < ApplicationController
  def index
    @invoices = Invoice.all
  end
  def show
    @invoice = Invoice.find(params[:id])
    @invoice_items = @invoice.find_item_info
    @total_revenue = @invoice.total_revenue
  end
end