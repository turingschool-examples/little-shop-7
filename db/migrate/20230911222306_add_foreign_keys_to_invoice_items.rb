class AddForeignKeysToInvoiceItems < ActiveRecord::Migration[7.0]
  def change
    add_foreign_key :invoice_items, :invoices
    add_foreign_key :invoice_items, :items
  end
end
