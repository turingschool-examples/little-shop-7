class Invoice < ApplicationRecord
  belongs_to :customer
  has_many :invoice_items
  has_many :transactions
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items

  enum status: {
                  'cancelled': 0,
                  'in progress': 1,
                  'completed': 2
                  }

  def format_created_at
    created_at.strftime("%A, %B %d, %Y")
  end
end