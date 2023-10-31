class Invoice < ApplicationRecord
  validates :status
  enum :status, {"in progress": 0, completed: 1, cancelled: 2}
  has_many :invoice_items,
  has_many :customers
  has_many :items, through: :invoice_items

end