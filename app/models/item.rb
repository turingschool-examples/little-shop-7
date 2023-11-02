class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  def invoice
    self.invoices.each do |invoice|
      invoice
    end
  end

  

  enum status: {"disabled": 0, "enabled": 1}
end