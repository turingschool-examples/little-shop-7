class Invoice < ApplicationRecord
  enum :status, { "in progress" => 0, "completed" => 1, "cancelled" => 2 }
  belongs_to :customer
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items

  validates :status, presence: true

  def self.incomplete_invoices
    where(status: "in progress")
  end

end
