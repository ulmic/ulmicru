module ActivityLines::Corporative::ConfessionScopes
  extend ActiveSupport::Concern
  include Concerns::StateMachine

  included do
    scope :removed, -> { where state: :removed }
    scope :confirmed, -> { where state: :confirmed }
    scope :on_vote, -> { where state: :on_vote }
    scope :declined, -> { where state: :declined }
    scope :unviewed, -> { where state: :unviewed }
    scope :debut, -> { where nomination: :debut }
    scope :number_one, -> { where nomination: :number_one }
    scope :of_the_year, -> (year) { where year: year }
  end
end
