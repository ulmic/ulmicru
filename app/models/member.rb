class Member < User
  belongs_to :parent, class_name: 'Member'
  has_many :attribute_accesses
  has_many :positions

  validates :patronymic, presence: true,
                         human_name: true
  validates :motto, presence: true
  validates :ticket, uniqueness: true
  validates :mobile_phone, presence: true,
                           phone: true
  validates :birth_date, presence: true
  validates :home_adress, presence: true
  validates :municipality, presence: true
  validates :locality, presence: true
  validates :avatar, presence: true

  scope :presented, -> { where('state != \'removed\' AND state != \'not_member\'') }
  scope :removed, -> { where state: :removed }
  scope :unviewed, -> { where state: :unviewed }

  state_machine :state, initial: :unviewed do
    state :unviewed
    state :confirmed
    state :declined
    state :removed
    state :not_member

    event :confirm do
      transition all => :confirmed
    end
    event :decline do
      transition all => :declined
    end
    event :remove do
      transition all => :removed
    end
    event :restore do
      transition removed: :unviewed
    end
  end
end
