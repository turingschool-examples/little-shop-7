class ChangeResultToBeIntegerInTransactions < ActiveRecord::Migration[7.0]
  def change
    change_column :transactions, :result, :integer, using: 'result::integer'
  end
end
