class Item < ApplicationRecord
  validates :name
  validates :description
  validates :unit_price
  has_many :merchant_id
end