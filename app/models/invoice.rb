class Invoice < ApplicationRecord
  belongs_to :customer
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items


  def self.unshipped_invoices
    Invoice.joins(:invoice_items)
          .where(invoice_items: { status: ['pending', 'packaged'] })
  end
end