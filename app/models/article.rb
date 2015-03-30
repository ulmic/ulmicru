class Article < ActiveRecord::Base
  belongs_to :category
  belongs_to :user

  validates :title,       presence: true
  validates :body,        presence: true
  validates :view,        presence: false
  validates :category_id, presence: true
  validates :user_id,     presence: true

  include ArticleScopes

  state_machine :state, initial: :unviewed do
    state :unviewed
    state :confirmed
    state :removed

    event :remove do
      transition all => :removed
    end
    event :confirm do
      transition all => :confirmed
    end
    event :restore do
      transition :removed => :unviewed
    end
  end
end
