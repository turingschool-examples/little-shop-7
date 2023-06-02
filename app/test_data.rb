# class CreateCustomer < ActiveRecord::Migration[7.0]
#   def change
#     create_table :customers do |t|
#       t.string :first_name
#       t.string :last_name
#       t.string :created_at
#       t.string :updated_at
#     end
#   end
# end


# class CreateMerchants < ActiveRecord::Migration[7.0]
#   def change
#     create_table :merchants do |t|
#       t.string :name
#       t.string :created_at
#       t.string :updated_at
#     end
#   end
# end


# class CreateInvoices < ActiveRecord::Migration[7.0]
#   def change
#     create_table :invoices do |t|
#       t.string :status
#       t.string :created_at
#       t.string :updated_at
#     end
#     add_reference :invoices, :customer, foreign_key: true
#   end
# end


# class CreateItems < ActiveRecord::Migration[7.0]
#   def change
#     create_table :items do |t|
#       t.string :name
#       t.string :description
#       t.integer :unit_price
#       t.string :created_at
#       t.string :updated_at
#     end
#     add_reference :items, :merchant, foreign_key: true
#   end
# end


# class CreateInvoiceItems < ActiveRecord::Migration[7.0]
#   def change
#     create_table :invoice_items do |t|
#       t.integer :quantity
#       t.integer :unit_price
#       t.string :status
#       t.string :created_at
#       t.string :updated_at
#     end
#     add_reference :invoice_items, :item, foreign_key: true
#     add_reference :invoice_items, :invoice, foreign_key: true
#   end
# end


# class CreateTransactions < ActiveRecord::Migration[7.0]
#   def change
#     create_table :transactions do |t|
#       t.string :credit_card_number
#       t.string :credit_card_expiration_date
#       t.string :result
#       t.string :created_at
#       t.string :updated_at
#     end
#     add_reference :transactions, :invoice, foreign_key: true
#   end
# end
