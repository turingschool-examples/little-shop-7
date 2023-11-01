class InvoiceItem < ApplicationRecord
  belongs_to :invoice, dependent: :destroy
  belongs_to :item, dependent: :destroy

enum status: { package: 0, pending: 1, shipped: 2 }

  
end