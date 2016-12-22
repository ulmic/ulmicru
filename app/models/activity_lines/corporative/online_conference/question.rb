class ActivityLines::Corporative::OnlineConference::Question < ActiveRecord::Base
  belongs_to :online_conference, class_name: 'ActivityLines::Corporative::OnlineConference'
  belongs_to :user
  has_many :logged_actions

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

  def is_answered?
    answer_timestamp.present?
  end
end
