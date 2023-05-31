class CreateItems < ActiveRecord::Migration[7.0]
  def change
    create_table :items, id: false, primary_key: :id do |t|
      t.integer :id, null: false
      t.string :name
      t.text :description
      t.integer :unit_price
      t.references :merchant, null: false, foreign_key: true
      t.integer :status

      t.timestamps

      t.index :id, unique: true
    end
  end
end
