class CreateInvoices < ActiveRecord::Migration[7.0]
  def change
    create_table :invoices, id: false, primary_key: :id do |t|
      t.integer :id, null: false
      t.references :customer, null: false, foreign_key: true
      t.integer :status

      t.timestamps

      t.index :id, unique: true
    end
  end
end
