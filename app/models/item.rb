class Item < ApplicationRecord
  validates :name
  validates :description
  validates :unit_price
end