class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  def invoice_ids
    self.invoice_items.where(status: 1).pluck(:invoice_id)
    
  end

  def packaged?
    return unless self.invoice_items.includes(:invoice_items).where(status: 1).exists?
    return self.name
  end

end