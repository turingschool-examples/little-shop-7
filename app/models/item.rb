class Item < ApplicationRecord   
   belongs_to :merchant
   has_many :invoice_items
   has_many :invoices, through: :invoice_items
  has_many :transactions, through: :invoices
  has_many :customers, through: :invoices

   enum :status, ["enabled", "disabled"]

   def self.enabled_items
      where(status: 0)
   end

   def self.disabled_items
      where(status: 1)
   end

   def self.top_5_items
      self.joins(:invoice_items, :invoices, :transactions)
      .where(transactions: { result: 0})
      .select("items.*, SUM(invoice_items.quantity * invoice_items.unit_price) as total_rev")
      .group("items.id")
      .order("total_rev DESC")
      .limit(5)
  end
end