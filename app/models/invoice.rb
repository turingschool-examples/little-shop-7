class Invoice < ApplicationRecord
  belongs_to :customer
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items

  validates_presence_of :status

  enum status: ["cancelled", "completed", "in progress"] # can = 0 com = 1 in p = 2 need to remigrate and make integers
end
