class ChangeScaleOfProductPrices < ActiveRecord::Migration
  def up
    change_column :products, :price_max, :decimal, precision: 30, scale: 2
    change_column :products, :price_min, :decimal, precision: 30, scale: 2
    change_column :products, :price_retail, :decimal, precision: 30, scale: 2
  end

  def down
    change_column :products, :price_max, :decimal
    change_column :products, :price_min, :decimal
    change_column :products, :price_retail, :decimal
  end
end
