class Merchant < ApplicationRecord
  has_many :items
  has_many :invoice_items, through: :items
  validates :name, presence: true

  enum status: {
    disabled: 0,
    enabled: 1
  }

  def self.top_5_merchants
    # Notes on Revenue Calculation:
      # - Only invoices with at least one successful transaction should count towards revenue
        # .where("transactions.result = ?", "success")
      # - Revenue for an invoice should be calculated as the sum of the revenue of all invoice items
      # - Revenue for an invoice item should be calculated as the invoice item unit price multiplied by the quantity (do not use the item unit price)
      # Merchant.joins(invoice_items: :item)
    Merchant.joins(invoice_items: [invoice: :transactions]).select("merchants.*", "sum(invoice_items.quantity * invoice_items.unit_price) as sales").where("transactions.result = ?", "1").group("merchants.id").order("sales desc").limit(5)
  end
end
