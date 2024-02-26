class Invoice < ApplicationRecord
   belongs_to :customer
   has_many :transactions
   has_many :invoice_items
   has_many :items, through: :invoice_items
   has_many :merchants, through: :items

   enum :status, [ "in progress", "completed", "cancelled" ] 

   def self.incomplete_invoices
      joins(:invoice_items).where(invoice_items: {status: ["pending", "packaged"]}).distinct.order(created_at: :asc)
   end

   # def items_ready_to_ship
   #    items.joins(:items)
   #       .select('items.name AS item_name, invoices.created_at AS invoice_created_at')
   #       .where.not(invoice_items: { status: 2 })
   #       .order("invoice_created_at")
   # end
end
