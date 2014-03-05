# == Schema Information
#
# Table name: comments
#
#  id               :integer          not null, primary key
#  content          :string(255)
#  user_id          :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  commentable_id   :integer
#  commentable_type :string(255)
#

class Comment < ActiveRecord::Base
  attr_accessible :content, :user_id, :commentable_id, :commentable_type, :parent_id

  belongs_to :commentable, polymorphic: true

  has_ancestry
end
