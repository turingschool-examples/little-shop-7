class CreateTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions do |t|
      t.references :invoice, null: false, foreign_key: true
      t.string :credit_card_number
      t.string :credit_card_expiration_date
      t.integer :result #int

      t.timestamps
    end
  end
end
