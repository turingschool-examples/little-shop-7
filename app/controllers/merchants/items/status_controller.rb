class Merchants::Items::StatusController < ApplicationController
  def update
    merchant = Merchant.find(params[:merchant_id])
    item = Item.find(params[:item_id])
    item.update({
      status: params[:status]
    })

    redirect_to merchant_items_path(merchant)
  end
end