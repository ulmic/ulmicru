module PositionScopes
  extend ActiveSupport::Concern

  included do
    scope :for_now, -> { where end_date: :for_now }
    scope :last_held_position, -> { order('end_date DESC').first }
  end
end
