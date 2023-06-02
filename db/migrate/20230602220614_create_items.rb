class CreateItems < ActiveRecord::Migration[7.0]
  def change
    create_table :items do |t|
      t.index :id, unique: true

      t.string :name
      t.integer :status
      t.text :description
      t.integer :unit_price
      t.references :merchant, null: false, foreign_key: true

      t.timestamps
    end
  end
end
