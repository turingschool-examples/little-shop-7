class Merchants::InvoicesController < ApplicationController

  def index
    @merchant = Merchant.find(params[:merchant_id])
    @invoices = @merchant.invoices
    
  end

  def show
    @invoice = Invoice.find(params[:id])
    @invoice_items = @invoice.invoice_items
    @invoice_total_revenue = @invoice.item_total_revenue 
  end
end