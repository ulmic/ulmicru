class Article < ActiveRecord::Base
  belongs_to :user
  belongs_to :category
  validates :title,       presence: true
  validates :body,        presence: true
  validates :user_id,     presence: false
  validates :view,        presence: false
  validates :category_id, presence: true


  state_machine :state, initial: :unviewed do
    state :unviewed
    state :removed

    event :remove do
      transition all => :removed
    end
    event :restore do
      transition :removed => :unviewed
    end
  end
end
