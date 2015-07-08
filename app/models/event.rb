class Event < ActiveRecord::Base
  belongs_to :creator, class_name: Member
  belongs_to :activity_line
  belongs_to :organizer, polymorphic: true,
                         foreign_key: :organizer_id
  has_many :registrations, class_name: 'Event::Registration'
  has_many :tags, as: :target, dependent: :destroy

  mount_uploader :main_photo, PhotoUploader

  include EventScopes
  include Concerns::DurationManagment

  extend Enumerize
  enumerize :organizer_type, in: [ 'Member', 'Team' ]

  state_machine :state, initial: :unviewed do
    state :unviewed
    state :declined
    state :confirmed
    state :removed

    event :confirm do
      transition all => :confirmed
    end

    event :remove do
      transition all => :removed
    end

    event :restore do
      transition all => :unviewed
    end
  end
  #FIXME tags association
  include Concerns::TagsHelper
end
