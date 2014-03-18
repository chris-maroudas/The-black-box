# == Schema Information
#
# Table name: posts
#
#  id           :integer          not null, primary key
#  title        :string(255)
#  content      :text
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  slug         :string(255)
#  category_id  :integer
#  featured     :boolean          default(FALSE)
#  published    :boolean          default(FALSE)
#  published_at :datetime
#

class Post < ActiveRecord::Base
  attr_accessible :content, :title, :taglist, :category_id, :published, :featured

  # Behavior related
  extend FriendlyId
  friendly_id :title, use: :slugged

  # Relationships
  has_and_belongs_to_many :tags
  has_many :comments, as: :commentable, dependent: :destroy
  belongs_to :category
  belongs_to :user

  # Validations
  validates :title, presence: true, uniqueness: true, length: { maximum: 120 }
  validates :content, presence: true, length: { maximum: 12000 }
  validates :category_id, presence: true

  # Hooks
  before_validation :strip_empty_space
  before_save :check_if_published_changed

  # Scopes
  default_scope order: 'created_at DESC'
  scope :recent, -> { where('created_at >= ?', 6.days.ago) }
  scope :published, -> { where(published: true) }

  # Methods
  def self.commented
    self.all.reject { |post| post.comments.blank? } # Candidate for refactoring, awful practice
  end

  def check_if_published_changed
    self.published_at = Time.now if "published".in? self.changed
  end

  def strip_empty_space
    self.title = title.strip if self.title
    self.content = content.strip if self.content
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
