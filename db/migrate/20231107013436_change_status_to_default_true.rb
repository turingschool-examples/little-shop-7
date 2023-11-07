class ChangeStatusToDefaultTrue < ActiveRecord::Migration[7.0]
  def change
    change_column(:merchants, :enabled, :boolean, default: true)
  end
end
