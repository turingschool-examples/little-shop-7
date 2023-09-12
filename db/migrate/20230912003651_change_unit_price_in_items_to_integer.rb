class ChangeUnitPriceInItemsToInteger < ActiveRecord::Migration[7.0]
  def change
    change_column :items, :unit_price, :integer
  end
end
