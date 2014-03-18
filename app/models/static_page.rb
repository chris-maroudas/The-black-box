# == Schema Information
#
# Table name: static_pages
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  content    :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class StaticPage < ActiveRecord::Base
  attr_accessible :content, :title

  extend FriendlyId
  friendly_id :title, use: :slugged

end
