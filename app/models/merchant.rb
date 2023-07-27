class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices, through: :items
  enum status: {enabled: "Enabled", disabled: "Disabled"}

  def distinct_invoices
    invoices.distinct
  end
end