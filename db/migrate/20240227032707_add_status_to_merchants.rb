class AddStatusToMerchants < ActiveRecord::Migration[7.1]
  def change
    add_column :merchants, :status, :integer, null: false, default: 0
  end
end
