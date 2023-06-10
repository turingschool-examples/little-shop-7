class CreateCoupons < ActiveRecord::Migration[7.0]
  def change
    create_table :coupons do |t|
      t.string :code, unique: true
      t.string :name
      t.integer :status, default: 0
      t.integer :value
      t.integer :coupon_type
      t.references :merchant, null: false, foreign_key: true

      t.timestamps
    end
  end
end
