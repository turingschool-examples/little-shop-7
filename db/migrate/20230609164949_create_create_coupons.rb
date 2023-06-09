class CreateCreateCoupons < ActiveRecord::Migration[7.0]
  def change
    create_table :coupons do |t|
      t.string :code
      t.string :name
      t.integer :status, default: 0
      t.integer :value
      t.integer :type
      t.references :merchant, null: false, foreign_key: true

      t.timestamps
    end
  end
end
