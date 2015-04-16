class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.string :type
      t.string :price_retail
      t.string :description

      t.timestamps null: false
    end
  end
end
