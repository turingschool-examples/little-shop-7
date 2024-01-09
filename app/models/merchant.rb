class Merchant < ApplicationRecord
  validates :name, presence: true
  has_many :items

  def item_ids
    Item.where(merchant_id: id).pluck(:id)
  end

end
