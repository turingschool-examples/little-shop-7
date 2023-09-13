require "csv"

class InvoiceItem < ApplicationRecord
  enum status: [:pending, :packaged, :shipped]
  belongs_to :item
  belongs_to :invoice
end
