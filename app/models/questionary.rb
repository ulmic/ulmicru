class Questionary < Member
  validates :experience, presence: true
  validates :want_to_do, presence: true
  validates :ticket, uniqueness: true,
                     allow_nil: true

  include QuestionaryScopes

  mount_uploader :avatar, AvatarUploader

  state_machine :state, initial: :unviewed do
    state :unviewed
    state :confirmed
    state :declined
    state :removed

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

  state_machine :member_state, initial: :unviewed do
    state :unviewed
    state :confirmed
    state :on_the_trial
    state :declined

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
  end
end
