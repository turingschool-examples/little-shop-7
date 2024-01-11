class Item < ApplicationRecord

  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  
  validates :name, presence: true
  validates :description, presence: true
  validates :unit_price, presence: true, numericality: true

  attribute :status, default: -> { 0 }

  enum status: {"Disabled" => 0, "Enabled" => 1}

  def self.top_5_by_revenue 
    self.joins(invoice_items: { invoice: :transactions })
      .select("items.*, MAX(invoice_items.unit_price * quantity) AS max_rev")
      .where("transactions.result = 1")
      .group("items.id")
      .order("max_rev DESC")
      .limit(5)
  end
end