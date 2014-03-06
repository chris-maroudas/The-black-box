class RenameApprovedToPublished < ActiveRecord::Migration
def change
  rename_column :posts, :approved, :published
end
end
