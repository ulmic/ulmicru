class Image < ActiveRecord::Base
  belongs_to :author, class_name: 'User'

  validates :file, presence: true
  validates :slug, presence: true
  validates :image_type, presence: true

  mount_uploader :image, PhotoUploader

  extend Enumerize
  enumerize :image_type, in: [ :photo, :just_image, :logo ]
end
