class CreateCustomers < ActiveRecord::Migration[7.0]
  def change
    create_table :customers, id: false, primary_key: :id do |t|
      t.integer :id, null: false
      t.string :first_name
      t.string :last_name

      t.timestamps

      t.index :id, unique: true
    end
  end
end
