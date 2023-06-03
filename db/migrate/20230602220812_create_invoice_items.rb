class CreateInvoiceItems < ActiveRecord::Migration[7.0]
  def change
    create_table :invoice_items do |t|
      t.index :id, unique: true

      t.integer :status
      t.references :invoice, null: false, foreign_key: true
      t.references :item, null: false, foreign_key: true
      t.integer :unit_price
      t.integer :quantity

      t.timestamps
    end
  end
end
