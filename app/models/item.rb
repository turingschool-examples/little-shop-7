class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  def invoice
    id = []
    self.invoices.each do |invoice|
      id << invoice.id
    end
    id
  end
end