class CreateInvoiceItems < ActiveRecord::Migration[7.0]
  def change
    create_table :invoice_items do |t|
      t.integer :quantity
      t.integer :unit_price
      t.string :status
      t.string :created_at
      t.string :updated_at
    end
    add_reference :invoice_items, :item, foreign_key: true
    add_reference :invoice_items, :invoice, foreign_key: true
  end
end
