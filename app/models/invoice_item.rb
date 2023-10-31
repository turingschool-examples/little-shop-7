class InvoiceItem < ApplicationRecord
  belongs_to :invoice
  belongs_to :item

  validates :quantity, presence: true
  validates :unit_price, presence: true
  validates :status, presence: true
  
  enum :status, {pending: 0, packaged: 1, shipped: 2}
end