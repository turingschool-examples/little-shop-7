class Invoice < ApplicationRecord
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :transactions
  belongs_to :customer

  enum status: {
    "cancelled": 0,
    "in progress": 1,
    "completed": 2
  }
  def self.incomplete_invoices
    joins(:invoice_items)
      .where(invoice_items: { status: [:packaged, :pending] })
      .where(status: "in progress")
      .distinct
      .order(created_at: :asc)
  end

end
