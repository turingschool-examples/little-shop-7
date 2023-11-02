class Merchant < ApplicationRecord
  has_many :items
  
  validates :name, presence: true

  def items_to_ship
    items.joins(:invoices)
  end
end