module NewsScopes
  extend ActiveSupport::Concern
  include Concerns::StateMachine

  included do
    scope :published, ->   { where('published_at <= ?', DateTime.now).where.not(state: :removed)}
    scope :unpublished, -> { where('published_at > ?',  DateTime.now).where.not(state: :removed)}
    scope :removed, -> { where state: :removed }
  end
end
