class AddFeaturedToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :featured, :boolean, default: false
    add_column :posts, :approved, :boolean, default:false
  end
end
