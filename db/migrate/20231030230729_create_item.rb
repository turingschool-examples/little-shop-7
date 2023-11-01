class CreateItem < ActiveRecord::Migration[7.0]
  def change
    create_table :items do |t|
      t.string :name
      t.string :description
      t.integer :unit_price
      # t.integer :merchant_id ##DROP

      t.timestamps
    end
  end
end
