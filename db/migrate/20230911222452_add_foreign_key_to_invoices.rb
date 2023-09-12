class AddForeignKeyToInvoices < ActiveRecord::Migration[7.0]
  def change
    add_foreign_key :invoices, :customers
  end
end
