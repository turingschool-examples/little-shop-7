class Invoice < ApplicationRecord
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :transactions
  belongs_to :customer

  validates :customer_id, presence: true, numericality: true
  validates :status, presence: true

  enum status: {"in progress": 0, "completed": 1, "cancelled": 2}

  def self.incomplete_not_shipped
    Invoice.joins(items: :invoice_items)
           .where(invoice_items: {status: ["pending", "packaged"]})
           .distinct
           .order(created_at: :asc)
  end

  def format_date
    created_at.strftime('%A, %B %e, %Y')
  end

  def total_revenue
    total = 0
    invoice_items.each do |invoice_item|
      total += invoice_item.quantity * invoice_item.unit_price
    end
    total
  end

end