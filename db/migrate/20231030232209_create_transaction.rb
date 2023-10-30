class CreateTransaction < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions do |t|
      t.integer :invoice_id
      t.bigint :credit_card_number
      t.date :credit_card_expiration_date
      t.integer :result

      t.timestamps
    end
  end
end
