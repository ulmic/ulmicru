module PositionScopes
  extend ActiveSupport::Concern

  included do
    scope :current_positions, -> { where for_now: 1 }
    scope :last_held_position, -> { order('end_date DESC').first }
  end
end
