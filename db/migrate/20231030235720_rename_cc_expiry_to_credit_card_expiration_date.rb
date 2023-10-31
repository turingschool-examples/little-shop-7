class RenameCcExpiryToCreditCardExpirationDate < ActiveRecord::Migration[7.0]
  def change
    rename_column(:transactions, :cc_expiry, :credit_card_expiration_date)
  end
end
