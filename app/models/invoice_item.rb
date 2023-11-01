class InvoiceItem < ApplicationRecord
  belongs_to :invoices
  belongs_to :items
  
  enum status: {"pending": 0, "packaged": 1, "shipped": 2}
end