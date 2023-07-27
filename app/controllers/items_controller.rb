class ItemsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @items = @merchant.items
  end
  
  def show
    @merchant = Merchant.find(params[:merchant_id])
    @item = @merchant.items.find(params[:id])
  end

  def edit
    @merchant = Merchant.find(params[:merchant_id])
    @item = @merchant.items.find(params[:id])
  end

  def update
    @merchant = Merchant.find(params[:merchant_id])
    @item = @merchant.items.find(params[:id])
  

    if params[:disable] == 'true'
      @item.disabled!
      flash[:success] = "Item successfully disabled."
      redirect_to merchant_items_path(@merchant)
    elsif params[:enable] == 'true'
      @item.enabled!
      flash[:success] = "Item successfully enabled."
      redirect_to merchant_items_path(@merchant)
    elsif @item.update(item_params)
      flash[:success] = "Item successfully updated."
      redirect_to merchant_item_path(@merchant, @item)
    else
      flash[:error] = "Failed to update item."
      redirect_to merchant_item_path(@merchant, @item)
    end
  end
  

  private

    def item_params
      params.require(:item).permit(:name, :description, :unit_price, :status)
    end

end