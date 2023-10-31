class RemoveStatusFromInvoices < ActiveRecord::Migration[7.0]
  def change
    remove_column :invoices, :status, :string
  end
end
