class MerchantInvoicesController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
    @invoice = Invoice.find(params[:id])
    # Return the invoice items specific to that merchant
    @merchant_invoice_items = @invoice.invoice_items.joins(:item).where("items.merchant_id = #{@merchant.id}")
  end
end
