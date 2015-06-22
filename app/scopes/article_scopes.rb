module ArticleScopes
  extend ActiveSupport::Concern
  include Concerns::StateMachine

  included do
    scope :removed, -> { where state: :removed }
    scope :presented, -> { where.not(state: :removed).order('id DESC')}
    scope :confirmed, -> { where(state: :confirmed).order('id DESC') }
    scope :inactive, -> { where(state: :inactive).order('id DESC') }
    scope :unviewed, -> { where(state: :unviewed).order('id DESC') }
  end
end
