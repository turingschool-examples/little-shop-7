class ChangeStatusDataTypeInInvoiceItems < ActiveRecord::Migration[7.0]
  def change
    change_column :invoice_items, :status, 'integer USING status::integer'
  end
end
