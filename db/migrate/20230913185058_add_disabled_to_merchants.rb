class AddDisabledToMerchants < ActiveRecord::Migration[7.0]
  def change
    add_column :merchants, :disabled, :boolean
  end
end