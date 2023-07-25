class Item < ApplicationRecord
  validates_presence_of :description
  validates_presence_of :unit_price
  validates_presence_of :merchant_id

  has_many :invoice_items
  has_many :invoices, through: :invoice_items
end