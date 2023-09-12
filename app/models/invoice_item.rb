require "csv"

class InvoiceItem < ApplicationRecord
  enum :status, packaged: "packaged", pending: "pending", shipped: "shipped"
end