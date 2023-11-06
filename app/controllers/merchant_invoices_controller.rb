class MerchantInvoicesController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
  end

  def show
    @invoice = Invoice.find(params[:invoices])
  end

  def update
    @invoice = Invoice.find(params[:invoices])

    if params[:item_update] == "Update_item"
      @item.update(item_params)
      flash[:alert] = "Update successful"
      redirect_to "/merchants/#{@item.merchant.id}/items/#{@item.id}"
    end
    if params[:commit] == "Enable"
      @item.update(enable: true)     
      redirect_to "/merchants/#{@item.merchant.id}/items"
    elsif params[:commit] == "Disable"
      @item.update(enable: false)
      redirect_to "/merchants/#{@item.merchant.id}/items"
    end
  end
end