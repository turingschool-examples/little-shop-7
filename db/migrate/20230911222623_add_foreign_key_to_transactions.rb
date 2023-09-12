class AddForeignKeyToTransactions < ActiveRecord::Migration[7.0]
  def change
    add_foreign_key :transactions, :invoices
  end
end
