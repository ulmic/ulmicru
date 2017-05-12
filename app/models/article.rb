class Article < ActiveRecord::Base
  belongs_to :category
  belongs_to :user
  has_many :tags, as: :record, dependent: :destroy
  has_and_belongs_to_many :attachments, class_name: 'Document'
  has_many :comments, as: :record,
                      dependent: :destroy
  has_many :page_views, class_name: 'View', as: :record
  has_many :logged_actions, as: :record

  validates :title,       presence: true
  validates :category_id, presence: true
  validates :user_id,     presence: true

  state_machine :state, initial: :unviewed do
    state :unviewed
    state :confirmed
    state :inactive
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
    event :make_inactive do
      transition all => :inactive
    end
  end

  include StateMachine::Scopes
  scope :presented, -> { where.not(state: :removed).order('id DESC')}
  scope :broadcasted, -> { where.not(category_id: Category.find_by_name('Контакты').id).where(state: :confirmed) }
  scope :same_articles, -> (article) { article.category.articles.where.not(id: article.id) }
  scope :popular, -> { order('views DESC') }
  scope :visible, -> { where publicity: :visible }
  scope :need_to_review, -> { where 'state = \'unviewed\' OR state = \'updated\'' }

  extend Enumerize
  enumerize :publicity, in: [ :visible, :access_on_link ], default: :visible
  enumerize :access, in: [ :all, :members ], default: :all

  include PgSearch
  pg_search_scope :search_everywhere, against: [:title, :body, :view]

  def self.collections
    [ :confirmed, :inactive, :unviewed ]
  end
end
