class ItemsController < ApplicationController
    def index
      @merchant = Merchant.find(params[:merchant_id])

    end
    def show
      @merchant = Merchant.find(params[:merchant_id])
      
      @item = Item.find(params[:id])
     
    end

    def edit
      @merchant = Merchant.find(params[:merchant_id])
      
      @item = Item.find(params[:id])

    end

    def update
      merchant = Merchant.find(params[:merchant_id])
      item = Item.find(item_params[:id])
      if params[:commit].include?("Enable") || params[:commit].include?("Disable")
        item.change_status(params[:commit])
        redirect_to merchant_items_path(merchant_id: merchant.id)
      else  
        item.update(item_params)
        flash[:notice] = 'Item successfully updated.'
        redirect_to merchant_item_path(merchant_id: merchant.id, id: item.id)
      end
    end





  private

  def item_params
    params.permit(:id, :name, :description, :unit_price)
   end

  end