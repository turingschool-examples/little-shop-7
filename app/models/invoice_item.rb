class InvoiceItem < ApplicationRecord
  
  belongs_to :invoice
  belongs_to :item

  validates_presence_of :quantity
  validates_presence_of :unit_price
  validates_presence_of :status
end