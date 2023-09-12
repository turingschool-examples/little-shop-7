class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoiceitems

  validates :name, presence: true
  validates :description, presence: true
  validates :unit_price, presence: true

  def unit_price_formatted
    unit_price.to_f / 100
  end
end
