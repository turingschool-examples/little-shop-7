class Item < ApplicationRecord
  validates_presence_of :name,
                        :description, 
                        :unit_price

  belongs_to :merchant
  has_many :invoice_items, dependent: :destroy
  has_many :invoices, through: :invoice_items
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices

  enum status: { enabled: 0, disabled: 1 }
end
