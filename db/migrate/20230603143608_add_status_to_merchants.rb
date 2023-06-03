class AddStatusToMerchants < ActiveRecord::Migration[7.0]
  def change
    add_column :merchants, :status, :string, :default => "enabled"
  end
end
