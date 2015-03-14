class Article < ActiveRecord::Base
  belongs_to :user

  validates :title,   presence: true
  validates :body,    presence: true
  validates :user_id, presence: true
  validates :view,    presence: false

  

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
