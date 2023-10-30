class CreateTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions do |t|
      t.integer :cc_number
      t.string :cc_expiry
      t.string :result

      t.timestamps
    end
  end
end
