class CreateInvoice < ActiveRecord::Migration[7.0]
  def change
    create_table :invoices do |t|
      # t.integer :customer_id ##DROP
      t.integer :status

      t.timestamps
    end
  end
end
