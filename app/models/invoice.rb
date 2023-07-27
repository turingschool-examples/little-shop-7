class Invoice < ApplicationRecord
  belongs_to :customer
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items

  def format_created_at
    created_at.strftime("%A, %B %d, %Y")
  end
end