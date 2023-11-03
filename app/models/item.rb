class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  validates :name, :description, :unit_price, presence: true

  def find_invoice_id(item)
    @id = InvoiceItem.find(:invoice_item = item)
    @id.invoice_id
  end
end