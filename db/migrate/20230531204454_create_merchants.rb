class CreateMerchants < ActiveRecord::Migration[7.0]
  def change
    create_table :merchants, id: false, primary_key: :id do |t|
      t.integer :id, null: false
      t.string :name
      t.integer :status

      t.timestamps

      t.index :id, unique: true
    end
  end
end
