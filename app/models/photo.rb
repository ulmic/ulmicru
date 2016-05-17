class Photo < ActiveRecord::Base
  belongs_to :author, class_name: 'User'

  validates :image, presence: true
  validates :slug, presence: true

  mount_uploader :image, PhotoUploader
end
