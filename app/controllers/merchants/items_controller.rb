class Merchants::ItemsController < ApplicationController
  
  def show
    @item = Item.find(params[:items_id])
  end 
end

