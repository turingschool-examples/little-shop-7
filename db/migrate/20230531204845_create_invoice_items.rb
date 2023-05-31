class CreateInvoiceItems < ActiveRecord::Migration[7.0]
  def change
    create_table :invoice_items, id: false, primary_key: :id do |t|
      t.integer :id, null: false
      t.references :item, null: false, foreign_key: true
      t.references :invoice, null: false, foreign_key: true
      t.integer :quantity
      t.integer :unit_price
      t.integer :status

      t.timestamps

      t.index :id, unique: true
    end
  end
end
