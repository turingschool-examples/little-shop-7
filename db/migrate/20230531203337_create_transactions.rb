class CreateTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions do |t|
      t.string :credit_card_number
      t.string :result
      t.string :created_at
      t.string :updated_at
    end
    add_reference :transactions, :invoice, foreign_key: true
  end
end
