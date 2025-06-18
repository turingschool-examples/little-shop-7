class ItemsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @items = @merchant.items
  end

  def show
    @merchant = Merchant.find(params[:merchant_id]);
    @item = @merchant.items.find(params[:id])
  end

  def toggle_status
    @merchant = Merchant.find(params[:merchant_id])
    @item = @merchant.items.find(params[:id])
    @item.update(enabled: !@item.enabled)
    status = @item.enabled ? "enabled" : "disabled"
    redirect_to merchant_items_path(@merchant), notice: "#{@item.name} status updated to #{status}."
  end
end
