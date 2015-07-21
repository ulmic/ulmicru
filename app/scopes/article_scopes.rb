module ArticleScopes
  extend ActiveSupport::Concern
  include Concerns::StateMachine

  included do
    scope :removed, -> { where state: :removed }
    scope :presented, -> { where.not(state: :removed).order('id DESC')}
    scope :confirmed, -> { where(state: :confirmed).order('id DESC') }
    scope :inactive, -> { where(state: :inactive).order('id DESC') }
    scope :unviewed, -> { where(state: :unviewed).order('id DESC') }
    scope :broadcasted, -> { where('category_id != ?', Category.find_by_name('Контакты').id).where(state: :confirmed) }
    scope :same_articles, -> (article) { article.category.articles.where.not(id: article.id) }
    scope :popular, -> { order('views DESC') }
  end
end
