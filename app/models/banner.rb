class Banner < ActiveRecord::Base
  mount_uploader :photo, PhotoUploader

  include BannerScopes
  include Concerns::DurationManagment

  state_machine :state, initial: :showed do
    state :showed
    state :hidden
    state :removed

    event :show do
      transition :hidden => :showed
    end
    event :hide do
      transition :showed => :hidden
    end
    event :remove do
      transition all => :removed
    end
    event :restore do
      transition removed: :hidden
    end
  end
end
