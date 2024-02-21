class Invoice < ApplicationRecord
  belongs_to :customer
  has_many :transactions, dependent: :destroy
  has_many :invoice_items, dependent: :destroy
  has_many :items, through: :invoice_items

  validates :status, presence: true
  
  enum status: ["In Progress", "Cancelled", "Completed"]

  # class method for checking status of invoice
  def self.incomplete_invoices
    Invoice.select("invoices.*").joins(:invoice_items).where("invoice_items.status != 2")
  end

end
