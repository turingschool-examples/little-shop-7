class AddEnabledToItems < ActiveRecord::Migration[7.1]
  def change
    add_column :items, :enabled, :boolean
  end
end
