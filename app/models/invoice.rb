class Invoice < ApplicationRecord
  belongs_to :customer
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items

  enum :status, { "in progress": 0, completed: 1, cancelled: 2 }

  def format_created_date
    created_at.to_date.to_formatted_s(:weekday_month_day_year)
  end

  def total_revenue
    invoice_items.sum("unit_price * quantity")
  end

  def total_revenue
    invoice_items.sum("unit_price * quantity")
  end
end
