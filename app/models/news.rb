class News < ActiveRecord::Base
  mount_uploader :photo,    PhotoUploader
  validates :title,         presence: true
  validates :body,          presence: true
  validates :published_at,  presence: true
  validates :photo,         presence: true
  validates :user_id,       presence: true
  validates :lead,          presence: true
  belongs_to :user

  def is_published?
    published_at <= DateTime.now
  end

  include NewsScopes

  state_machine :state, initial: :unviewed do
    state :unviewed
    state :removed

    event :remove do
      transition all => :removed
    end
    event :restore do
      transition :removed => :unviewed
    end
  end
end
