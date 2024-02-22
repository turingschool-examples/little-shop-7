class Invoice < ApplicationRecord
  belongs_to :customer
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items

  validates :status, presence: true

  enum status: {
    in_progress: 0,
    cancelled: 1,
    completed: 2
  }
end
