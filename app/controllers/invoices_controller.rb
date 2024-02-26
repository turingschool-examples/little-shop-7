class InvoicesController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @invoices = @merchant.invoices.distinct
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
    @invoice = @merchant.invoices.find(params[:id])
    @invoice_items = @invoice.invoice_items.joins(:item).where(items: {merchant_id: @merchant.id})
    @total_revenue = @invoice_items.sum("invoice_items.unit_price * quantity")
  end
end
