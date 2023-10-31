class InvoiceItem < ApplicationRecord
  has_many :invoices
  has_many :items
  validates :quantity
  validates :unit_price
  validates :status
  enum :status, {pending: 0, packaged: 1, shipped: 2}
end