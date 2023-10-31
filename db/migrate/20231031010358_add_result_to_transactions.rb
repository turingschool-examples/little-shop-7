class AddResultToTransactions < ActiveRecord::Migration[7.0]
  def change
    add_column :transactions, :result, :integer
  end
end
