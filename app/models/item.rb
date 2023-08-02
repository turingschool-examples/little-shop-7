class Item < ApplicationRecord
  validates_presence_of :description
  validates_presence_of :unit_price
  validates_presence_of :merchant_id
  validates :status, inclusion: { in: [true, false] }, exclusion: nil

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

  def top_selling_date
    top_selling = invoices.joins(:invoice_items)
                .group(:created_at)
                .order('sum(invoice_items.quantity) desc')
                .select(:created_at)
                .first
    top_selling&.created_at&.strftime('%B %-d, %Y')
  end
end


