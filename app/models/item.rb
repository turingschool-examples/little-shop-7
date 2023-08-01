class Item < ApplicationRecord
  validates_presence_of :description
  validates_presence_of :unit_price
  validates_presence_of :merchant_id
  validates_presence_of :status

  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items 
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices

  def update_status
    if self.status 
      self.update_attribute(:status, false)
    else
      self.update_attribute(:status, true)
    end
  end
end


