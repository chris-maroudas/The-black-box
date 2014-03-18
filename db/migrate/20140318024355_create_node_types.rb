class CreateNodeTypes < ActiveRecord::Migration
  def change
    create_table :node_types do |t|
      t.string :name
      t.string :controller
      t.string :action

      t.timestamps
    end
  end
end
