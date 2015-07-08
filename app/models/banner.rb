class Banner < ActiveRecord::Base
  mount_uploader :photo, PhotoUploader

  validates :link, url: true
  validate :begin_before_end_date

  include BannerScopes
  include Concerns::DurationManagment


  state_machine :state, initial: :showed do
    state :showed
    state :unviewed
    state :removed

    event :show do
      transition :unviewed => :showed
    end
    event :hide do
      transition :showed => :unviewed
    end
    event :remove do
      transition all => :removed
    end
    event :restore do
      transition removed: :unviewed
    end
  end
end
