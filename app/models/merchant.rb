class Merchant < ApplicationRecord
   has_many :items, dependent: :destroy
   has_many :invoice_items, through: :items
   has_many :invoices, through: :invoice_items
   has_many :customers, through: :invoices
   
   validates :name, presence: true

   def top_five_customers
      Customer.select("customers.*, count(transactions.id) as count_transactions")
         .joins(:transactions).where(transactions: {result: "success"})
         .group('customers.id')
         .order("count_transactions DESC")
         .limit(5)
   end

   def invoices_with_items_ready_to_ship
      invoices.joins(:items)
         .where.not(invoice_items: { status: 2 })      
         .select("invoices.*, items.name AS item_name, items.id AS item_id, invoice_items.id AS ii_id")
         .order("invoices.created_at")
         .distinct
   end

   def shipable_items
      invoices_with_items_ready_to_ship.each_with_object({}) do |invoice, hash|
         hash[invoice.id] ||= { names: [], created_at: [], item_ids: [] }
         hash[invoice.id][:names] << invoice.item_name
         hash[invoice.id][:created_at] << invoice.created_at 
         hash[invoice.id][:item_ids] << invoice.item_id
      end
   end
end


