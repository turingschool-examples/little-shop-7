class ChangeCreditCardNumberInTransactions < ActiveRecord::Migration[7.0]
  def change
    change_column :transactions, :credit_card_number, :string
  end
end
