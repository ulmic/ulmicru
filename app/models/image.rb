class Image < ActiveRecord::Base
  belongs_to :author, class_name: 'User'

  validates :file, presence: true
  validates :image_type, presence: true

  mount_uploader :file, PhotoUploader

  extend Enumerize
  enumerize :image_type, in: [ :photo, :just_image, :logo ]

  include StateMachine::Scopes

  state_machine :state, initial: :active do
    state :active
    state :removed

    event :remove do
      transition all => :removed
    end
  end

  include PgSearch
  pg_search_scope :search_everywhere, against: [ :author_name ],
    associated_against: {
      author: [ :first_name, :last_name, :patronymic ]
    }
end
