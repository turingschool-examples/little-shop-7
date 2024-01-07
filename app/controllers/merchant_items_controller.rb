class MerchantItemsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @items = @merchant.items
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
    @item = @merchant.items.find(params[:id])
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
    @item = Item.new
  end

  def create
    merchant = Merchant.find(params[:merchant_id])
    item = Item.create({
      name: params[:item][:name],
      description: params[:item][:description],
      unit_price: params[:item][:unit_price],
      merchant_id: merchant.id,
      status: 1,
      created_at: Time.now,
      updated_at: Time.now
    })
    redirect_to "/merchants/#{merchant.id}/items"
#     merchant = Merchant.find(params[:merchant_id])
#     item = Item.create(item_params)
#  redirect_to "/merchants/#{merchant.id}/items"


    # if item.save
    #   redirect_to "/merchants/#{merchant.id}/items"
    # elsif !item.save
    #   flash[:notice] = "All essential information not provided, please try again."
    #   redirect_to "/merchants/#{merchant.id}/items/new"
    # end
  end


  def edit
    @merchant = Merchant.find(params[:merchant_id])
    @item = @merchant.items.find(params[:id])
  end

  def update
    merchant = Merchant.find(params[:merchant_id])
    item = Item.find(params[:id])
    item.update(item_params)
    if params[:commit].starts_with?("Update")
      redirect_to "/merchants/#{merchant.id}/items/#{item.id}"
      flash[:alert] = "Information has been successfully updated"
    # elsif params[:commit] == 0 || 1
    #   require 'pry'; binding.pry
    #   params[:item][:enabled] || params[:item][:disabled]
    #   item.update(status: params[:commit])
    #   redirect_to "/merchants/#{merchant.id}/items"
      elsif params[:item][:enabled]
        item.update(status: 0)
        # item.update(status: params[:item][:enabled])
        redirect_to "/merchants/#{merchant.id}/items"
      else params[:item][:disabled]
        item.update(status: 1)
        # item.update(status: params[:item][:disabled])
        redirect_to "/merchants/#{merchant.id}/items"
      end
    # else
    #   redirect_to "/merchants/#{merchant.id}/items/#{item.id}"
    #   flash[:alert] = "Information has been successfully updated"
    

  end

  private

  def item_params
    params.require(:item).permit(:id, :name, :description, :unit_price)
    
  end

end