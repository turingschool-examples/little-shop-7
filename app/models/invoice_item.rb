require "csv"

class InvoiceItem < ApplicationRecord
  enum status: [:pending, :packaged, :shipped]
  belongs_to :items
  belongs_to :invoices
end
