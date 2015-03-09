class News < ActiveRecord::Base
  mount_uploader :photo,    PhotoUploader
  validates :title,         presence: true
  validates :body,          presence: true
  validates :published_at,  presence: true
  validates :photo,         presence: false 
  validates :user_id,       presence: true
  belongs_to :user

  def is_published?
    published_at <= DateTime.now
  end

  scope :published, ->   { where('published_at <= ?', DateTime.now).where.not(state: :removed)}
  scope :unpublished, -> { where('published_at > ?',  DateTime.now).where.not(state: :removed)}
  scope :removed, -> { where state: :removed }

  state_machine :state, initial: :unviewed do
    state :unviewed
    state :confirmed
    state :declined
    state :removed

    event :confirm do
      transition all => :confirmed
    end
    event :decline do
      transition all => :declined
    end
    event :remove do
      transition all => :removed
    end
    event :restore do
      transition :removed => :unviewed
    end
  end
end
