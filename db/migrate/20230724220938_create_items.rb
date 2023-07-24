class CreateItems < ActiveRecord::Migration[7.0]
  def change
    create_table :items do |t|
      t.string :description
      t.integer :unit_price
      t.integer :merchant_id

      t.timestamps
    end
  end
end
