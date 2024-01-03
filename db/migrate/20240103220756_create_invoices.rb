class CreateInvoices < ActiveRecord::Migration[7.0]
  def change
    create_table :invoices, id: false do |t|
      t.integer :id
      t.integer :customer_id
      t.integer :status
      t.datetime :created_at
      t.datetime :updated_at

    end
  end
end
