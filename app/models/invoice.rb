class Invoice < ApplicationRecord 
  validates :status, presence: true

  enum :status, ["completed", "in progress", "cancelled"]

  belongs_to :customer
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items  
  has_many :transactions

  def self.incomplete_invoices
    joins(:invoice_items)
      .where(invoice_items: { status: [1, 2] })
      .distinct
      .order(created_at: :asc)
  end


  def find_item_info
    InvoiceItem.where(invoice_id: id).includes(:item)
  end


  def total_revenue
    invoice_items.sum { |item| item.quantity * item.unit_price }
  end



  def item_total_revenue
    self.invoice_items.sum("quantity * unit_price")
  end

  def revenue
    invoice_items.sum("unit_price * quantity")
  end

end