class Team < ActiveRecord::Base
  belongs_to :member
  has_and_belongs_to_many :users
  has_many :events, as: :organizer,
                    foreign_key: :organizer_id
  has_many :protocols

  validates :description, presence: true

  extend Enumerize
  enumerize :publicity, in: [ :visible, :hidden ], default: :hidden

  state_machine :state, initial: :unviewed do
    state :unviewed
    state :active
    state :removed
    state :updated
    state :closed

    event :confirm do
      transition all => :active
    end
    event :remove do
      transition all => :removed
    end
    event :restore do
      transition all => :unviewed
    end
    event :close do
      transition all => :closed
    end
  end

  include StateMachine::Scopes

  scope :visible, -> { where publicity: :visible }
  scope :hidden, -> { where publicity: :hidden }
  scope :presented, -> { where.not(state: :removed) }
  scope :need_to_review, -> { where 'state = \'unviewed\' OR state = \'updated\'' }

  include TagsHelper
  include Concerns::ReviewManagment

  def is_departament?
    model_name == 'Team::Departament'
  end

  def is_administration?
    model_name == 'Team::Administration'
  end

  def is_subdivision?
    model_name == 'Team::Subdivision'
  end

  def is_primary?
    model_name == 'Team::Primary'
  end

  def is_committee?
    model_name == 'Team::Committee'
  end

  def is_ulmic_team?
    model_name.in? [ 'Team::Departament', 'Team::Primary', 'Team::Committee', 'Team::Administration', 'Team::Subdivision' ]
  end

  def is_another_team?
    model_name == 'Team::AnotherTeam'
  end

  def is_presidium?
    title == 'Президиум'
  end

  alias members users

  #FIXME return to decorator without draper https://trello.com/c/zHYwI7h3/672-draper. Draper is too long

  include RussianCases

  def full_title(type_case = nil)
    team_type = I18n.t("activerecord.attributes.team.types.#{type.split(':').last.downcase}")
    if is_departament?
      "#{type_case ? send(type_case, team_type) : team_type} в #{instrumental(municipality)}"
    elsif is_primary?
      "#{type_case ? send(type_case, team_type) : team_type} в #{school}"
    elsif is_committee?
      if project
        "#{type_case ? send(type_case, team_type) : team_type} #{project.decorate.title}"
      else
        'Исправь это!!'
      end
    else
      type_case ? send(type_case, title) : title
    end
  end
  include PgSearch
  pg_search_scope :search_everywhere, against: [:title, :description, :municipality, :school]

  def self.collections
    [ :active, :unviewed, :closed, :removed ]
  end
end
