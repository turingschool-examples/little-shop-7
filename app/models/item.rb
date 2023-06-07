class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  has_many :transactions, through: :invoices
  validates_presence_of :name, :description, :unit_price

  enum status: ["disabled", "enabled"]

  def self.sort_enabled
    where(status: "enabled")
  end

  def self.sort_disabled
    where(status: "disabled")
  end

  def self.top_5_items_by_revenue
    joins(:transactions)
    .select("items.*, sum(invoice_items.unit_price * invoice_items.quantity) AS total_revenue")
    .where("transactions.result = 0")
    .group("items.id")
    .order("total_revenue desc")
    .limit(5)
  end

  def best_day
    x = invoices
    .select("invoices.*, sum(invoice_items.unit_price * invoice_items.quantity) AS total_revenue")
    .where('invoices.status = 1')
    .group("invoices.id")
    .order("total_revenue desc, invoices.created_at desc")
    .limit(1).first.created_at
    .to_datetime.strftime("%Y-%m-%d")
  end
end

