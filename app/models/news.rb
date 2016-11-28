class News < ActiveRecord::Base
  belongs_to :member, foreign_key: :user_id
  has_many :tags, as: :record,
                  dependent: :destroy
  has_many :comments, as: :record,
                      dependent: :destroy
  has_many :logged_actions, as: :record
  has_and_belongs_to_many :attachments, class_name: 'Document'

  mount_uploader :photo,    PhotoUploader
  validates :title,         presence: true
  validates :body,          presence: false
  validates :published_at,  presence: true
  validates :user_id,       presence: true
  validates :lead,          presence: false
  validates :state,         presence: true

  def is_published?
    published_at <= DateTime.now && state != 'removed'
  end

  def is_not_published?
    not is_published?
  end

  include Concerns::ViewsManagment

  class << self
    include NearRecords
  end

  state_machine :state, initial: :unviewed do
    state :unviewed
    state :confirmed
    state :main
    state :removed

    event :confirm do
      transition all => :confirmed
    end
    event :remove do
      transition all => :removed
    end
    event :to_main do
      transition all => :main
    end
    event :restore do
      transition :removed => :unviewed
    end
  end

  include PgSearch
  pg_search_scope :search_everywhere, against: [:title, :body, :lead]

  def category
    activity_line_tag = tags.activity_lines.first
    activity_line_tag.target.title if activity_line_tag
  end
end
