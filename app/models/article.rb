class Article < ActiveRecord::Base
  belongs_to :category
  belongs_to :user
  has_many :tags, as: :record, dependent: :destroy
  has_and_belongs_to_many :attachments, class_name: 'Document'
  has_many :comments, as: :record,
                      dependent: :destroy

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

  extend Enumerize
  enumerize :publicity, in: [ :visible, :access_on_link ], default: :visible

  include Concerns::ViewsManagment
  include PgSearch
  pg_search_scope :search_everywhere, against: [:title, :body, :view]
end
