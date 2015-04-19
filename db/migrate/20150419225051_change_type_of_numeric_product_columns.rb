class ChangeTypeOfNumericProductColumns < ActiveRecord::Migration
  def up
    change_column :products, :oid, :integer
    change_column :products, :price_max, :decimal
    change_column :products, :price_min, :decimal
    change_column :products, :price_retail, :decimal
  end

  def down
    change_column :products, :oid, :string
    change_column :products, :price_max, :string
    change_column :products, :price_min, :string
    change_column :products, :price_retail, :string
  end
end
