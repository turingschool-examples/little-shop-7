class CreateTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions, id: false do |t|
      t.integer :id
      t.integer :invoice_id
      t.string :credit_card_number
      t.string :credit_card_expiration_date
      t.string :result
      t.datetime :created_at
      t.datetime :updated_at
    end
  end
end
