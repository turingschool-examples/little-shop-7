class MerchantInvoicesController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @merchant_invoices = @merchant.merchant_invoices
  end
end
