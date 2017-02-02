class ActivityLines::Lider::YaLider::Participation < ActiveRecord::Base
  belongs_to :participant, class_name: 'ActivityLines::Lider::YaLider::Participant'
  belongs_to :stage, class_name: 'ActivityLines::Lider::YaLider::Stage'

  validates :participant_id, uniqueness: { scope: :stage },
                             presence: true

  state_machine :state, initial: :active do
    state :active
    state :removed
  end
end
