class ChangeCcDatatypeInTransactions < ActiveRecord::Migration[7.0]
  def change
    change_column :transactions, :credit_card_number, 'varchar USING credit_card_number::varchar'
    change_column :transactions, :result, 'integer USING result::integer'
  end
end
