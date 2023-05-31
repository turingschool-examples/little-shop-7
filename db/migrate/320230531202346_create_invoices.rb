class CreateInvoices < ActiveRecord::Migration[7.0]
  def change
    create_table :invoices do |t|
      t.string :status
      t.string :created_at
      t.string :updated_at
    end
    add_reference :invoices, :customer, foreign_key: true
  end
end
