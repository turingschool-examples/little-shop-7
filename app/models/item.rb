class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices

  enum status: { disabled: 0, enabled: 1 }

  validates :name, presence: true
  validates :description, presence: true
  validates :unit_price, presence: true, numericality: true
  
  # write method to convert string to integer for unit_price
  def formatted_unit_price
    unit_price_in_cents = self.unit_price
    dollars = unit_price_in_cents / 100
    cents = unit_price_in_cents % 100
    sprintf("$%d.%02d", dollars, cents)
  end

  def disabled?
    status == "disabled"
  end

  def enabled?
    status == "enabled"
  end
end