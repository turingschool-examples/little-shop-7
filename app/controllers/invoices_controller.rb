class InvoicesController < ApplicationController
  def index
    @invoices = Invoice.all
    @invoice_items = InvoiceItem.all
    @merchant = Merchant.find(params[:merchant_id])
  end
  
  def show
 
  end
end