class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  validates :merchant, presence: true

  def invoice
    self.invoices.each do |invoice|
      invoice
    end
  end
end