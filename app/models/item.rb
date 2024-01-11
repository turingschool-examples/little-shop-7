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
end