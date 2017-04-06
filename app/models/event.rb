class Event < ActiveRecord::Base
  belongs_to :creator, class_name: User
  belongs_to :activity_line
  belongs_to :organizer, polymorphic: true,
                         foreign_key: :organizer_id
  has_many :registrations, class_name: 'Event::Registration'
  has_many :tags, as: :target, dependent: :destroy
  has_many :logged_actions, as: :record
  has_one :online_conference, class_name: 'ActivityLines::Corporative::OnlineConference'
  has_and_belongs_to_many :places

  mount_uploader :main_photo, PhotoUploader

  extend Enumerize
  enumerize :organizer_type, in: [ 'Member', 'Team', 'User' ]

  state_machine :state, initial: :unviewed do
    state :unviewed
    state :declined
    state :confirmed
    state :removed
    state :updated

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

  #FIXME try fix active form
  after_save :remove_empty_registrations

  include DurationManagment
  include TagsHelper

  include PgSearch
  pg_search_scope :search_everywhere, against: [:title, :description]

  def is_online_conference?
    title&.include? I18n.t('activerecord.attributes.activity_lines/corporative/online_conference.event_title')
  end

  def is_ya_lider_event?
    ::ActivityLines::Lider::YaLider::ParticipantEvent.where(event_id: self.id).any?
  end

  private

  def remove_empty_registrations
    registrations.where(user_id: nil).map &:destroy
  end
end
