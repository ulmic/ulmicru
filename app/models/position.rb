class Position < ActiveRecord::Base
  belongs_to :member

  validates :begin_date, presence: true
  validates :end_date, presence: true
  validate :begin_before_end_date

  include PositionScopes
  include Concerns::DurationManagment
end
