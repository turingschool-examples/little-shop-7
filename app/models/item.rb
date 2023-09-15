class Item < ApplicationRecord
  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  belongs_to :merchant

  def formatted_date
    created_at.strftime("%A, %B %d, %Y")
    # "Monday, July 18, 2019"
  end
end