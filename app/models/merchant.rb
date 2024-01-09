class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices, through: :items
  has_many :transactions, through: :invoices
  validates :name, presence: true

  enum status: {
    disabled: 0,
    enabled: 1
  }

  def revenue
    # Notes on Revenue Calculation:
      # - Only invoices with at least one successful transaction should count towards revenue
        .where("transactions.result = ?", "success")
      # - Revenue for an invoice should be calculated as the sum of the revenue of all invoice items
      # - Revenue for an invoice item should be calculated as the invoice item unit price multiplied by the quantity (do not use the item unit price)
    require 'pry'; binding.pry
    .where("transactions.result = ?", "success")
  end
end
