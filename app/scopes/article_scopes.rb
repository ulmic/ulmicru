require 'scopes_rails/state_machine/scopes'

module ArticleScopes
  extend ActiveSupport::Concern
  include StateMachine::Scopes

  included do
    scope :presented, -> { where.not(state: :removed).order('id DESC')}
    scope :broadcasted, -> { where.not(category_id: Category.find_by_name('Контакты').id).where(state: :confirmed) }
    scope :same_articles, -> (article) { article.category.articles.where.not(id: article.id) }
    scope :popular, -> { order('views DESC') }
    scope :visible, -> { where publicity: :visible }
    scope :need_to_review, -> { where 'state = \'unviewed\' OR state = \'updated\'' }
  end
end
