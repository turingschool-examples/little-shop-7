class MerchantInvoicesController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @merchant_invoices = @merchant.merchant_invoices
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
    @invoice = Invoice.find(params[:id]) #@invoice.items for items on invoice and @invoice.invoice_items[0].unit_price for invoice items
    @customer = Customer.find(@invoice.customer_id)
  end
end
