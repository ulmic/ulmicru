class Questionary < Member
  validates :experience, presence: true
  validates :want_to_do, presence: true

  mount_uploader :avatar, AvatarUploader

  state_machine :state, initial: :unviewed do
    state :unviewed
    state :confirmed
    state :declined
    state :removed
    state :updated
    state :corrupted_email

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

    event :set_corrupted_email do
      transition all => :corrupted_email
    end
  end

  state_machine :member_state, initial: :unviewed do
    state :unviewed
    state :confirmed
    state :on_the_trial
    state :trial_passed
    state :declined
    state :updated
    state :changes_expectation

    event :confirm do
      transition all => :confirmed
    end

    event :decline do
      transition all => :declined
    end

    event :renew do
      transition all => :unviewed
    end

    event :put_on_the_trial do
      transition all => :on_the_trial
    end
    
    event :pass_trial do
      transition all => :trial_passed
    end

    event :change_expect do
      transition all => :changes_expectation
    end
  end

  include StateMachine::Scopes

  scope :unviewed, -> { where(member_state: :unviewed).order('id DESC') }
  scope :presented, -> { where.not(state: :removed) }
  scope :member_on_the_trial, -> { where(member_state: :on_the_trial).order(request_date: :desc) }
  scope :member_declined, -> { where(member_state: :declined).order(request_date: :desc) }
  scope :member_trial_passed, -> { where(member_state: :trial_passed).order(request_date: :desc)}
  scope :member_changes_expectation, -> { where(member_state: :changes_expectation).order(request_date: :desc) }
  scope :need_to_review, -> { where 'member_state = \'unviewed\' OR member_state = \'updated\'' }

  include Concerns::ActionLoggerManagment
  include PgSearch
  pg_search_scope :search_everywhere, against: [:email, :first_name, :last_name, :patronymic, :motto, :ticket, :mobile_phone, :home_adress, :municipality, :locality, :experience, :want_to_do, :school ]

  def self.collections
    [ :member_on_the_trial, :member_changes_expectation,  :unviewed, :member_declined, :member_trial_passed ]
  end
end
