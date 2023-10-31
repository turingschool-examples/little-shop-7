class RemoveStatusFromInvoiceItems < ActiveRecord::Migration[7.0]
  def change
    remove_column :invoice_items, :status, :string
  end
end
