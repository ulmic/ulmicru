class Position < ActiveRecord::Base
  belongs_to :member

  validate :begin_before_end_date

  include PositionScopes
  include Concerns::DurationManagment
end
