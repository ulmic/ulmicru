class Article < ActiveRecord::Base
  belongs_to :category
  belongs_to :user
  has_many :tags, as: :record, dependent: :destroy
  has_and_belongs_to_many :attachments, class_name: 'Document'

  validates :title,       presence: true
  validates :category_id, presence: true
  validates :user_id,     presence: true

  include ArticleScopes
  include Concerns::ViewsManagment

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
