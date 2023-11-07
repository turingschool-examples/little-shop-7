class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  has_many :transactions, through: :invoices

  validates :name, :description, :unit_price, :status, presence: true

  enum :status, {enabled: 0, disabled: 1}

  def format_price
    format('%.2f', (self.unit_price / 100.0)).prepend("$")
  end

  def created_format
    created_at.strftime("%A, %B %d, %Y")
  end


  def price_total
    self.invoice_items.sum("quantity * unit_price")
  end
  
  def total_revenue
    invoice_items.joins(invoice: :transactions)
    .where(transactions: {result: 0})
    .sum("invoice_items.unit_price * invoice_items.quantity")
  end
end