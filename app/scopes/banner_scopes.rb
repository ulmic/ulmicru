module BannerScopes
  extend ActiveSupport::Concern
  include Concerns::StateMachine

  included do
    scope :presented, -> { where.not(state: :removed).order('id ASC') }
  end
end
