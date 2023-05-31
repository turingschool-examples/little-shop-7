class Item < ApplicationRecord
  belongs_to :merchant
  belongs_to :invoice_item
  belongs_to :invoice, through: :invoice_item
end
