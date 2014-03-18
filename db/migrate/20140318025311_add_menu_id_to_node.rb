class AddMenuIdToNode < ActiveRecord::Migration
  def change
    add_column :nodes, :menu_id, :integer
  end
end
