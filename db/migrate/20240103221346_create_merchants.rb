class CreateMerchants < ActiveRecord::Migration[7.0]
  def change
    create_table :merchants, id: false do |t|
      t.integer :id
      t.string :name
      t.datetime :created_at
      t.datetime :updated_at

    end
  end
end
