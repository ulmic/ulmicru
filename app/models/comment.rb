class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :parent, class: 'Comment'
  belongs_to :record, polymorphic: true
  has_many :children, foreign_key: :parent_id

  validates :record_id, presence: true
  validates :record_type, presence: true
  validates :text, presence: true,
                   uniqueness: { scope: [ :user_id, :record_id ] }

  extend Enumerize
  enumerize :record_type, in: [ 'Article', 'News', 'ActivityLines::Corporative::Confession', 'Event' ]
  enumerize :comment_type, in: [ :user, :admin ]

  state_machine :state, initial: :unviewed do
    state :unviewed
    state :active
    state :removed

    event :make_active do
      transition all => :active
    end
    event :remove do
      transition all => :removed
    end
  end
end
