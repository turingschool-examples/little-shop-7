class Merchant < ApplicationRecord
  has_many :items

  def item_ids
    Item.where(merchant_id: id).pluck(:id)
  end

end
