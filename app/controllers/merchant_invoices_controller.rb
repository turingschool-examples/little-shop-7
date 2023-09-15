class MerchantInvoicesController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @merchant_invoices = @merchant.invoices  #remove, uses @merchant.invoices in webpage
  end

  def show
    @invoice = Merchant.find(params[:merchant_id]).where("invoices.id = #{params[:invoice_id]}")
    # @invoice = @merchant.find(params[:invoice_id])
  end
end