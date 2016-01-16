module VoteScopes
  extend ActiveSupport::Concern

  included do
    scope :likes, -> { where difference: 1 }
    scope :dislikes, -> { where difference: -1 }
  end
end
