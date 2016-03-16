require 'scopes_rails/state_machine/scopes'

module BannerScopes
  extend ActiveSupport::Concern
  include StateMachine::Scopes

  included do
    scope :active, -> { where(state: :active).order('created_at ASC') }
    scope :presented, -> { where.not(state: :removed).order('id ASC') }
    scope :with_vertical, -> { where.not(vertical: nil) }
    scope :with_horizontal, -> { where.not(horizontal: nil) }
    scope :actual, -> { where('begin_date < ? AND end_date > ?', DateTime.now, DateTime.now) }
  end
end
