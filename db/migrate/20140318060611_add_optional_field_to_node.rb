class AddOptionalFieldToNode < ActiveRecord::Migration
  def change
    add_column :nodes, :optional_field, :string
  end
end
