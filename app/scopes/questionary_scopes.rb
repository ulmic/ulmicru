module QuestionaryScopes
  extend ActiveSupport::Concern
  include ApplicationScopes

  included do
    scope :unviewed, -> { where state: :unviewed }
    scope :presented, -> { where.not(state: :removed) }
    scope :removed, -> { where state: :removed }
  end
end
