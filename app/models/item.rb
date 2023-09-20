class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items

  validates :name, presence: true
  validates :description, presence: true
  validates :unit_price, presence: true

  enum status: { 'disabled' => 0, 'enabled' => 1 }

  def unit_price_formatted
    unit_price.to_f / 100
  end
end
