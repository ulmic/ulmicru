class News < ActiveRecord::Base
  mount_uploader :photo,    PhotoUploader
  validates :title,         presence: true
  validates :body,          presence: true
  validates :published_at,  presence: true
  validates :photo,         presence: false 
  validates :author_id,     presence: true

  def is_published?
    published_at <= DateTime.now
  end


  extend Enumerize

  scope :published, -> { where "published_at <= ?", DateTime.now}
  scope :unpublished, -> { where "published_at > ?", DateTime.now}

end
