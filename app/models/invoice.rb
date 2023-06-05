class Invoice < ApplicationRecord
  self.primary_key = :id
  has_many :invoice_items
  has_many :items, through: :invoice_items
  belongs_to :customer
  has_many :transactions
  has_many :merchants, through: :items
  enum :status, ["cancelled", "in progress", "completed"]

  def self.sorted_incomplete_invoices
    Invoice.joins(:invoice_items)
    .where("invoice_items.status !=2")
    .group(:id)
    .order(:created_at)
  end

end
