class RenameCcNumberToCreditCardNumber < ActiveRecord::Migration[7.0]
  def change
    rename_column(:transactions, :cc_number, :credit_card_number)
  end
end
