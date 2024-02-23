class InvoiceItem < ApplicationRecord
   belongs_to :item
   belongs_to :invoice

   enum :status, ["pending", "packaged", "shipped"]

   def converted_unit_price 
      unit_price.to_f/100
   end
end