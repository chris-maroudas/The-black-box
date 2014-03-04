# == Schema Information
#
# Table name: posts
#
#  id          :integer          not null, primary key
#  title       :string(255)
#  content     :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  slug        :string(255)
#  category_id :integer
#

class Post < ActiveRecord::Base
  attr_accessible :content, :title, :taglist, :category_id

  # Behavior related
  extend FriendlyId
  friendly_id :title, use: :slugged

  # Relationships
  has_and_belongs_to_many :tags
  has_many :comments, as: :commentable
  belongs_to :category

  # Validations
  validates :title, presence: true, uniqueness: true, length: { maximum: 120 }
  validates :content, presence: true, length: { maximum: 12000 }
  validates :category_id, presence: true

  # Hooks
  before_validation :strip_empty_space

  #scopes
  default_scope order: 'created_at DESC'


  # Methods

  def strip_empty_space
    self.title = title.strip
    self.content = content.strip
  end

  def should_generate_new_friendly_id?
    new_record?
  end

  def taglist
    tags.collect do |tag|
      tag.name
    end.join(", ")
  end

  def taglist=(tags_string)
    tag_names = tags_string.split(",").collect{ |s| s.strip.downcase }.uniq # Create an array with the unique, normalized tags received
    new_or_found_tags = tag_names.collect { |name| Tag.find_or_create_by_name(name) } # Create the tags, if they don't exist

    self.tags = new_or_found_tags # and associate them with this article
  end


end
