class RemoveResultFromTransactions < ActiveRecord::Migration[7.0]
  def change
    remove_column :transactions, :result, :string
  end
end
