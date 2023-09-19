class ChangeInvoiceItemStatusToInteger < ActiveRecord::Migration[7.0]
  def change
    change_column :invoice_items, :status, :integer, using: 'status::integer'
  end
end
