module NewsScopes
  extend ActiveSupport::Concern
  include Concerns::StateMachine

  included do
    scope :published, -> {
      where('published_at <= ?', DateTime.now).
      where.not(state: :removed).
      order('published_at DESC')
    }
    scope :unpublished, -> {
      where('published_at > ?',  DateTime.now).
      where.not(state: :removed).
      order('published_at DESC')
    }
    scope :removed, -> { where state: :removed }
  end
end
