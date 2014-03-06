class AddPublishedAtToPost < ActiveRecord::Migration
  def change
    add_column :posts, :published_at, :datetime, default: nil
  end
end
