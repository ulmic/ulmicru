class ActivityLine < ActiveRecord::Base
  extend Enumerize
  belongs_to :member
  has_many :events
  has_many :tag, as: :target

  mount_uploader :logo, PhotoUploader

  enumerize :activity_type, in: [ :central_program, :local_project ]

  state_machine :state, initial: :active do
    state :active
    state :removed

    event :remove do
      transition all => :removed
    end

    event :restore do
      transition removed: :active
    end
  end
end
