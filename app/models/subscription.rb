class Subscription < ActiveRecord::Base
  belongs_to :receiver, polymorphic: true
  belongs_to :project

  has_one :token, as: :record, dependent: :destroy

  extend Enumerize
  enumerize :subscription_type, in: [ :deliveries, :project ]
  enumerize :receiver_type, in: [ 'User', 'Delivery::ContactEmail' ]

  include StateMachine::Scopes

  scope :string, -> { where tag_type: :string }
  scope :members, -> { where target_type: 'Member' }
  scope :events, -> { where target_type: 'Event' }
  scope :activity_lines, -> { where target_type: 'ActivityLine' }
  scope :teams, -> { where target_type: 'Team' }
  scope :news, -> { where record_type: 'News' }
  scope :articles, -> { where record_type: 'Article' }
  scope :empty, -> { active.where tag_type: :link, target_id: nil }
  scope :project, -> (project_id) { where subscription_type: :project, project_id: project_id }

  validates :subscription_type, uniqueness: { scope: [:receiver_id, :receiver_type] }
end
