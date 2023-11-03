class Items::StatusController < ApplicationController
  def update
    item = Item.find(params[:id])
    item.update({
      status: params[:status],
    })

    redirect_to merchant_items_path(@merchant_1)
  end
end