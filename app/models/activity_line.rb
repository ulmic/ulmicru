class ActivityLine < ActiveRecord::Base
  extend Enumerize

  validates :activity_type, presence: true

  belongs_to :member
  has_many :events
  has_many :tags, as: :target, dependent: :destroy

  mount_uploader :logo, PhotoUploader

  enumerize :activity_type, in: [ :central_program, :local_project, :corporative, :event_line ]
  enumerize :organization_type, in: [ :ulmic, :not_ulmic ]

  state_machine :state, initial: :active do
    state :unviewed
    state :active
    state :removed
    state :closed

    event :remove do
      transition all => :removed
    end

    event :restore do
      transition removed: :unviewed
    end

    event :close do
      transition active: :closed
    end
  end

  include StateMachine::Scopes

  scope :presented, -> { where.not(state: :removed).order('id ASC')}
  scope :central_programs, -> { where activity_type: :central_program }
  scope :local_projects, -> { where activity_type: :local_project }
  scope :corporative, -> { where activity_type: :corporative }
  scope :has_curators, -> { where.not(activity_type: :event_line) }
  scope :ulmic, -> { where organization_type: :ulmic }
  scope :need_to_review, -> { where 'state = \'unviewed\' OR state = \'updated\'' }

  include TagsHelper
  include PgSearch
  pg_search_scope :search_everywhere, against: [:title]

  #FIXME return to decorator without draper https://trello.com/c/zHYwI7h3/672-draper. Draper is too long
  include RussianCases
  def full_title(type_case = nil)
    if activity_type.corporative? || activity_type.event_line?
      if type_case
        send type_case, title
      else
        title
      end
    else
      type = I18n.t("enumerize.activity_line.activity_type.#{activity_type}")
      if type_case
        "#{send(type_case, type)} «#{title}»"
      else
        "#{type} «#{title}»"
      end
    end
  end

  def self.lider
    where(title: 'Лидер').first
  end

  def self.collections
    [ :active, :unviewed, :removed, :closed ]
  end
end
