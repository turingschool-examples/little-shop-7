class Item < ApplicationRecord

  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  
  validates :name, presence: true
  validates :description, presence: true
  validates :unit_price, presence: true, numericality: true
  attribute :status, default: -> { 0 }

  enum status: {"Disabled" => 0, "Enabled" => 1}
  def self.ready_to_ship
    self.joins(invoice_items: :invoice)
      .select("items.*, invoices.id AS invoice_id, invoices.created_at AS invoice_date")
      .where("invoice_items.status != 2")
  end

  def self.top_5_by_revenue 
    self.joins(invoice_items: { invoice: :transactions })
      .select("items.*, MAX(invoice_items.unit_price * quantity) AS max_rev")
      .distinct
      .where("transactions.result = 1")
      .group("items.id")
      .order("max_rev DESC")
      .limit(5)
  end

  def top_selling_date 
    self.invoice_items.joins(invoice: :transactions)
      .select("MAX(invoice_items.unit_price * invoice_items.quantity) AS max_rev, invoices.created_at AS sale_date")
      .distinct
      .where("transactions.result = 1")
      .group("invoices.created_at")
      .order("max_rev DESC")
      .limit(1)
      .first
  end

end