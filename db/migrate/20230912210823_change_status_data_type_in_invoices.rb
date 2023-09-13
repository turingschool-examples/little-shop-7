class ChangeStatusDataTypeInInvoices < ActiveRecord::Migration[7.0]
  def change
    change_column :invoices, :status, 'integer USING status::integer'
  end
end
