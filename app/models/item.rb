class Item < ApplicationRecord 
  enum :status, {disabled: 0, enabled: 1}
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  validates :name, :description, presence: true
  validates_numericality_of :unit_price, presence: true

  def current_price
    price = (unit_price * 0.01).round(3)
    "$#{price}"
  end

  def self.enabled_items
    where('status = 1')
  end

  def self.disabled_items
    where('status = 0')
  end
end 