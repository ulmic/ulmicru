class Event < ActiveRecord::Base
  belongs_to :creator, class_name: User
  belongs_to :activity_line
  belongs_to :organizer, polymorphic: true,
                         foreign_key: :organizer_id
  has_many :registrations, class_name: 'Event::Registration'
  has_many :tags, as: :target, dependent: :destroy
  has_many :logged_actions, as: :record
  has_many :admin_comments, -> { where(comment_type: :admin) }, class_name: 'Comment', as: :record
  has_one :online_conference, class_name: 'ActivityLines::Corporative::OnlineConference'
  has_and_belongs_to_many :places
  has_many :page_views, class_name: 'View', as: :record

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

  include StateMachine::Scopes

  scope :presented, -> { where.not(state: :removed) }
  scope :future, -> { where('begin_date >= ?', DateTime.now).where.not(state: :removed).order('id DESC') }
  scope :current, -> do
    where('begin_date < ? AND end_date > ?', DateTime.now, DateTime.now).where.not(state: :removed).order('id DESC')
  end
  scope :past, -> { where('end_date <= ?', DateTime.now).where.not(state: :removed).order('id DESC') }
  scope :near_future, -> { where('begin_date <= ?', DateTime.now + 3.month).order('begin_date DESC') }
  scope :need_to_review, -> { where 'state = \'unviewed\' OR state = \'updated\'' }

  #FIXME try fix active form
  after_save :remove_empty_registrations

  include DurationManagment
  include TagsHelper
  include Concerns::ActionLoggerManagment

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
