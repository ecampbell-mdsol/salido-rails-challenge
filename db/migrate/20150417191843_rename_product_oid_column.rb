class RenameProductOidColumn < ActiveRecord::Migration
  def change
    change_table :products do |t|
      t.rename :oid, :endeca_id
    end
  end
end
