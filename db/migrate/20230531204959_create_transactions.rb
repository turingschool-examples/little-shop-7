class CreateTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions, id: false, primary_key: :id do |t|
      t.integer :id, null: false
      t.references :invoice, null: false, foreign_key: true
      t.string :credit_card_number
      t.string :credit_card_expiration_date, null: true 
      t.integer :result

      t.timestamps

      t.index :id, unique: true
    end
  end
end
