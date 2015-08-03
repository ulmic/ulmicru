module BannerScopes
  extend ActiveSupport::Concern
  include Concerns::StateMachine

  included do
    scope :active, -> { where(state: :active).order('created_at ASC') }
    scope :unviewed, -> { where(state: :unviewed).order('id DESC') }
    scope :presented, -> { where.not(state: :removed).order('id ASC') }
    scope :removed, -> { where state: :removed }
    scope :with_vertical, -> { where.not(vertical: nil) }
    scope :with_horizontal, -> { where.not(horizontal: nil) }
  end
end
