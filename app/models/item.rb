class Item < ApplicationRecord
  belongs_to :merchant
  has_may :invoice_items
  has_many :invoices, through: :invoice_items
  
end