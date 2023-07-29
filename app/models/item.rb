class Item < ApplicationRecord 
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  def current_price
    price = (unit_price * 0.001).round(2)
    "$#{price}"
  end
end 