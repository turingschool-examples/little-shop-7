class Item < ApplicationRecord
  validates_presence_of :description
  validates_presence_of :unit_price
  validates_presence_of :merchant_id

  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items 
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices
end