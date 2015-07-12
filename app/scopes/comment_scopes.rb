module CommentScopes
  extend ActiveSupport::Concern
  include Concerns::StateMachine

  included do
    scope :unviewed, -> { where(state: :unviewed).order('id DESC') }
    scope :active, -> { where(state: :active).order('id DESC') }
    scope :declined, -> { where(state: :declined).order('id DESC') }
  end
end
