class RenameProductEndecaIdColumn < ActiveRecord::Migration
  def change
    change_table :products do |t|
      t.rename :endeca_id, :oid
    end
  end
end
