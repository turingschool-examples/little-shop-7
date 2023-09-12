class CreateInvoices < ActiveRecord::Migration[7.0]
  def change
    create_table :invoices do |t|
      t.integer :customer_id
      t.string :status

      t.timestamps
    end
  end
end
