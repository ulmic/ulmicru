class ActivityLines::Corporative::Image < ActiveRecord::Base
  belongs_to :member
  belongs_to :confession

  validates :member_id, presence: true
  validates :confession_id, presence: true
  validates :file, presence: true

  mount_uploader :file, PhotoUploader
end
