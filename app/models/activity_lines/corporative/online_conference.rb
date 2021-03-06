class ActivityLines::Corporative::OnlineConference < ActiveRecord::Base
  has_many :questions, class_name: 'ActivityLines::Corporative::OnlineConference::Question'
  belongs_to :event

  validates :title, uniqueness: true, presence: true
  validates :video_link, youtu_dot_be_video_link: true

  state_machine :state, initial: :active do
    state :active
    state :removed

    event :restore do
      transition all => :active
    end
    event :remove do
      transition all => :removed
    end
  end

  include StateMachine::Scopes

  scope :future, -> { active.where('date > ?', DateTime.now) }
  scope :past, -> { active.where('date < ?', DateTime.now) }

  include PgSearch
  pg_search_scope :search_everywhere, against: [ :title, :video_link ]

  def self.collections
    [ :future, :past, :removed ]
  end
end
