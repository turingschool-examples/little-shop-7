class CreateInvoiceItems < ActiveRecord::Migration[7.0]
  def change
    create_table :invoice_items, id: false do |t|
      t.integer :id
      t.integer :item_id
      t.integer :invoice_id
      t.integer :quantity
      t.integer :unit_price
      t.integer :status
      t.datetime :created_at
      t.datetime :updated_at
      
    end
  end
end
