class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  def invoice_date
    # return unless self.invoice_items.where(status: 1)
    return self.created_at.strftime("%A, %B %-d, %Y")
  end

  def packaged
    return unless self.invoice_items.includes(:invoice_items).where(status: 1).exists?
    return self
  end

  def invoice_id
    return self.invoice_items.pluck(:invoice_id).first
    
  end

end