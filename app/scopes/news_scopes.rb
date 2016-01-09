module NewsScopes
  extend ActiveSupport::Concern
  include Concerns::StateMachine

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
  end
end
