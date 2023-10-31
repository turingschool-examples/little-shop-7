class AddInvoicesAndItemsToInvoiceItems < ActiveRecord::Migration[7.0]
  def change
    add_reference :invoice_items, :invoice, null: false, foreign_key: true
    add_reference :invoice_items, :item, null: false, foreign_key: true
  end
end
