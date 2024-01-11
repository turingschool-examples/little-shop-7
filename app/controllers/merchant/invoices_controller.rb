class Merchant::InvoicesController < ApplicationController 
  def index 
    @merchant = Merchant.find(params[:merchant_id])
    @invoice_items = @merchant.invoice_items
  end
  
  def show
  end
end
