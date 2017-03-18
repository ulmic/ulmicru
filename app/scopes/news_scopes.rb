require 'scopes_rails/state_machine/scopes'

module NewsScopes
  extend ActiveSupport::Concern
  include StateMachine::Scopes

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
    scope :popular, -> do
      news = published.where('published_at <= ? AND published_at >= ?', DateTime.now, DateTime.now - 1.month)
      views_count = news.reduce({}) do |hash, n|
        hash.merge! n.id => n.page_views.count
      end.sort_by { |_key, value| value }.reverse
      views_count.map do |v|
        News.find(v[0])
      end
    end
    scope :actual, -> { where("published_at > CURRENT_DATE - INTERVAL'6 days'") }
    scope :presented, -> { where.not(state: :removed) }
    scope :need_to_review, -> { where 'state = \'unviewed\' OR state = \'updated\'' }
    scope :feed, -> (id) { published.where.not(id: id).first 3 }
  end
end
