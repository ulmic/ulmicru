class Team < ActiveRecord::Base
  belongs_to :member
  has_many :tags, as: :target

  validates :title, presence: true

  include TeamScopes

  state_machine :state, initial: :unviewed do
    state :unviewed
    state :active
    state :removed

    event :confirm do
      transition all => :active
    end
    event :remove do
      transition all => :removed
    end
    event :restore do
      transition all => :unviewed
    end
  end
  #FIXME tags association
  include Concerns::TagsHelper
end
