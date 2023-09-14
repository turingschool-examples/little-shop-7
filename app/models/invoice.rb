require "csv"

class Invoice < ApplicationRecord
  enum status: ["completed", "cancelled", "in progress"]
  has_many :invoice_items
  has_many :items, through: :invoice_items
  belongs_to :customer
  has_many :transactions

  def self.incomplete
    where("status != 0")
  end

  def formatted_date
    created_at.strftime("%A, %B %d, %Y")
    # "Monday, July 18, 2019"
  end
end