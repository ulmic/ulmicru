require 'scopes_rails/state_machine_scopes'

module NewsScopes
  extend ActiveSupport::Concern
  include StateMachineScopes

  included do
    scope :published, -> {
      where('published_at <= ?', DateTime.now).
      where("state = 'confirmed' OR state = 'main'").
      order('published_at DESC')
    }
    scope :unpublished, -> {
      where('published_at > ?',  DateTime.now).
      where(state: :confirmed).
      order('published_at DESC')
    }
    scope :popular, -> {
      where('published_at <= ?', DateTime.now).
      order('views DESC')
    }
    scope :actual, -> { where("published_at > CURRENT_DATE - INTERVAL'6 days'") }
    scope :presented, -> { where.not(state: :removed) }
  end
end
