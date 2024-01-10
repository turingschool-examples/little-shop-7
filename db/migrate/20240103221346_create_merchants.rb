class CreateMerchants < ActiveRecord::Migration[7.0]
  def change
    create_table :merchants do |t|
      t.string :name
      t.datetime :created_at
      t.datetime :updated_at
    end
  end
end
