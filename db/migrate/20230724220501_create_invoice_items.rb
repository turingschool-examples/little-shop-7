class CreateInvoiceItems < ActiveRecord::Migration[7.0]
  def change
    create_table :invoice_items do |t|
      t.integer :item_id
      t.integer :invoice_id
      t.integer :quantity
      t.integer :unit_price
      t.integer :status

      t.timestamps
    end
  end
end
