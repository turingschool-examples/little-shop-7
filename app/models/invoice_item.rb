class InvoiceItem < ApplicationRecord
  validates :quantity, presence: true
  validates :unit_price, presence: true
  validates :status, presence: true

  belongs_to :invoice
  belongs_to :item

  enum status: { pending: 0, packaged: 1, shipped: 2 }
  # enum status: ["pending", "packaged", "shipped"]
end
