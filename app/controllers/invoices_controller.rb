class InvoicesController < ApplicationController
  def index
    @invoices = Invoice.all
    @invoice_items = InvoiceItem.all
    @merchant = Merchant.find(params[:merchant_id])
  end
  
  def show
    @invoice = Invoice.find(params[:id])
    @merchant = Merchant.find(params[:merchant_id])
  end

  def update
    @merchant = Merchant.find(params[:merchant_id])
    @invoice = Invoice.find(params[:id])
    @invoice.update({
      status: params[:invoice][:status]})
    
    redirect_to merchant_invoice_path(@merchant, @invoice)
  end
end