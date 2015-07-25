class Member < User
  belongs_to :parent, class_name: 'Member'
  has_many :children, class_name: 'Member',
                      foreign_key: :parent_id
  has_many :attribute_accesses, dependent: :destroy
  has_many :positions, dependent: :destroy
  has_many :tags, as: :target,
                  foreign_key: :target_id,
                  dependent: :destroy
  has_and_belongs_to_many :teams, foreign_key: :user_id
  has_many :events, as: :organizer,
                    foreign_key: :organizer_id
  has_many :news, foreign_key: :user_id

  validates :first_name, human_name: true,
                         allow_blank: true
  validates :last_name, human_name: true,
                        allow_blank: true
  validates :patronymic, human_name: true,
                         allow_blank: true
  validates :ticket, uniqueness: true,
                     allow_blank: true
  validates :mobile_phone, phone: true,
                           allow_blank: true
  validates :motto, uniqueness: true,
                    allow_blank: true
  validates :avatar, presence: true

  include MemberScopes
  enumerize :municipality, in: Municipalities.list, default: Municipalities.list.first
  enumerize :locality, in: Localities.list, default: Localities.list.first
  enumerize :school, in: Schools.list

  mount_uploader :avatar, AvatarUploader

  state_machine :state, initial: :unviewed do
    state :unviewed
    state :confirmed
    state :declined
    state :removed
    state :unavailable

    event :confirm do
      transition all => :confirmed
    end
    event :decline do
      transition all => :declined
    end
    event :remove do
      transition all => :removed
    end
    event :avail do
      transition all => :unviewed
    end
    event :unavail do
      transition all => :unavailable
    end
    event :restore do
      transition removed: :unviewed
    end
  end

  state_machine :member_state, initial: :unviewed do
    state :unviewed
    state :confirmed
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
  end

  def has_auth_provider?(provider)
    authentications.map do |authentication|
      return authentication if authentication.provider == provider
    end
    nil
  end

  #FIXME tags association
  include Concerns::TagsHelper
end
