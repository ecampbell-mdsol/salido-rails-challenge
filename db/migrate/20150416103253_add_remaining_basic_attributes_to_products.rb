class AddRemainingBasicAttributesToProducts < ActiveRecord::Migration
  def change
    add_column :products, :oid, :string
    add_column :products, :price_max, :string
    add_column :products, :price_min, :string
    add_column :products, :url, :string
    add_column :products, :year, :string
  end
end
