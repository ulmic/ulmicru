module TagScopes
  extend ActiveSupport::Concern
  include Concerns::StateMachine

  included do
    scope :string, -> { where tag_type: :string }
  end
end
