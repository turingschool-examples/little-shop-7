class Invoice < ApplicationRecord
  belongs_to :customer
  has_many :transactions, dependent: :destroy
  has_many :invoice_items, dependent: :destroy
  has_many :items, through: :invoice_items


  enum status: { cancel: 0, in_progress: 1, completed: 2 }
end