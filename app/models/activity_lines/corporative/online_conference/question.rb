class ActivityLines::Corporative::OnlineConference::Question < ActiveRecord::Base
  belongs_to :online_conference, class_name: 'ActivityLines::Corporative::OnlineConference'
  belongs_to :user
  has_many :logged_actions, as: :record

  validates :text, uniqueness: true

  state_machine :state, initial: :unviewed do
    state :unviewed
    state :active
    state :removed

    event :remove do
      transition all => :removed
    end 
    event :restore do
      transition all => :active
    end
  end

  include StateMachine::Scopes

  scope :need_to_review, -> { unviewed }
  scope :asked, -> { active.where answer_timestamp: nil }
  scope :answered, -> { active.where.not answer_timestamp: nil }

  def is_answered?
    answer_timestamp.present?
  end

  def self.collections
    [ :unviewed, :asked, :answered, :removed ]
  end
end
