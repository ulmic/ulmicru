class News < ActiveRecord::Base
  belongs_to :member, foreign_key: :user_id
  has_many :tags, as: :record,
                  dependent: :destroy
  has_many :comments, as: :record,
                      dependent: :destroy
  has_many :logged_actions, as: :record
  has_many :admin_comments, -> { where(comment_type: :admin) }, class_name: 'Comment', as: :record
  has_and_belongs_to_many :attachments, class_name: 'Document'
  has_many :page_views, class_name: 'View', as: :record

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

  include StateMachine::Scopes

  scope :published, -> {
    where('published_at <= ?', DateTime.now).
    where("state = 'confirmed' OR state = 'main'").
    order('published_at DESC')
  }
  scope :unpublished, -> {
    where('published_at > ?',  DateTime.now).
    where(state: :confirmed).
    order('published_at DESC')
  }
  scope :popular, -> do
    news = published.where('published_at <= ? AND published_at >= ?', DateTime.now, DateTime.now - 1.month)
    views_count = news.reduce({}) do |hash, n|
      hash.merge! n.id => n.page_views.count
    end.sort_by { |_key, value| value }.reverse
    views_count.map do |v|
      News.find(v[0])
    end
  end
  scope :actual, -> { where("published_at > CURRENT_DATE - INTERVAL'6 days'") }
  scope :presented, -> { where.not(state: :removed) }
  scope :need_to_review, -> { where 'state = \'unviewed\' OR state = \'updated\'' }
  scope :feed, -> (id) { published.where.not(id: id).first 3 }
  include Concerns::ActionLoggerManagment
  include PgSearch
  pg_search_scope :search_everywhere, against: [:title, :body, :lead]

  def category
    activity_line_tag = tags.activity_lines.first
    activity_line_tag.target.title if activity_line_tag
  end
end
