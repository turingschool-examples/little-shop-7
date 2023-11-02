class RemoveForeignKeyFromInvoices < ActiveRecord::Migration[7.0]
  def change
    remove_foreign_key :invoices, :merchants
  end
end
