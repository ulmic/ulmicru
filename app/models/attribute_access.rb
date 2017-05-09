class AttributeAccess < ActiveRecord::Base
  belongs_to :member

  validates :member_id, presence: true
  validates :member_attribute, presence: true
  validates :access, presence: true

  extend Enumerize
  enumerize :access, in: [ :visible, :hidden ], default: :hidden

  include StateMachine::Scopes

  scope :active, -> { where(state: :active).order('created_at ASC') }
  scope :presented, -> { where.not(state: :removed).order('id ASC') }
  scope :with_vertical, -> { where.not(vertical: nil) }
  scope :with_horizontal, -> { where.not(horizontal: nil) }
  scope :actual, -> { where('begin_date < ? AND end_date > ?', DateTime.now, DateTime.now) }
  scope :need_to_review, -> { where 'state = \'unviewed\' OR state = \'updated\'' }
end
