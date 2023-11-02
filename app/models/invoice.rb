class Invoice < ApplicationRecord
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :transactions
  belongs_to :customer

  validates :status, presence: true

  enum :status, {"in progress": 0, "completed": 1, "cancelled": 2}

  def date_format
    self.created_at.strftime("%A, %B %d, %Y")
  end
end