class Invoice < ApplicationRecord
  validates :status, presence: true
  
  belongs_to :customer
  has_many :transactions, dependent: :destroy
  has_many :invoice_items, dependent: :destroy
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items

  enum status: ["In Progress", "Cancelled", "Completed"]
  
  # class method for checking status of invoice
  def self.invoices_with_unshipped_items
    Invoice.select("invoices.*").joins(:invoice_items).where("invoice_items.status != 2")
  end

  def self.oldest_to_newest
    Invoice.order("invoices.created_at")
  end

  def self.invoices_with_unshipped_items_oldest_to_newest
    Invoice.invoices_with_unshipped_items.oldest_to_newest
  end
end
