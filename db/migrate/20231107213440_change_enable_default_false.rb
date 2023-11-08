class ChangeEnableDefaultFalse < ActiveRecord::Migration[7.0]
  def change
    change_column_default :merchants, :enabled, false
  end
end
