class InvoiceItem < ApplicationRecord
  belongs_to :invoice
  belongs_to :item

  enum status: {
    "packaged": 0,
    "pending": 1,
    "shipped": 2
  }

  def self.revenue
    InvoiceItem.sum("invoice_items.quantity * invoice_items.unit_price")/100
  end
end
