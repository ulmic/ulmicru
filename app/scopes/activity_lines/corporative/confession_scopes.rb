module ActivityLines::Corporative::ConfessionScopes
  extend ActiveSupport::Concern
  include Concerns::StateMachine

  included do
    scope :debut, -> { where nomination: :debut }
    scope :number_one, -> { where nomination: :number_one }
    scope :of_the_year, -> (year) { where year: year }
  end
end
