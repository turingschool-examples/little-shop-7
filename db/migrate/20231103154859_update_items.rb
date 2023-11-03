class UpdateItems < ActiveRecord::Migration[7.0]
  def change
    add_column :items, :enable, :boolean, :default => true
  end
end
