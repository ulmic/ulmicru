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
  has_many :led_teams, class_name: 'Team',
                       foreign_key: :member_id
  has_many :events, as: :organizer,
                    foreign_key: :organizer_id
  has_many :news, foreign_key: :user_id
  has_many :authored_news, -> { published }, foreign_key: :user_id, class_name: 'News'
  has_many :authored_articles, -> { visible.broadcasted }, foreign_key: :user_id, class_name: 'Article'
  has_many :confessions, class_name: 'ActivityLines::Corporative::Confession',
                         dependent: :destroy
  has_many :views, as: :record, foreign_key: :record_id, class_name: 'View'


  #validates :email, uniqueness: true
  validates :first_name, human_name: true,
                         allow_blank: true
  validates :last_name, human_name: true,
                        allow_blank: true
  validates :patronymic, human_name: true,
                         allow_blank: true
  #validates :ticket, uniqueness: { scope: :state },
  #                   allow_blank: true
  validates :mobile_phone, phone: true,
                           allow_blank: true
  validates :motto, uniqueness: true,
                    allow_blank: true
  #validates :avatar, presence: true, if: Proc.new { state != "unavailable" && state != "corrupted_email" }
  validates :corporate_email, ulmic_email: true,
                              email: true,
                              uniqueness: true,
                              allow_blank: true

  enumerize :municipality, in: Municipalities.list, default: Municipalities.list.first
  enumerize :locality, in: Localities.list, default: Localities.list.first
  enumerize :school, in: Schools.list

  state_machine :state, initial: :unviewed do
    state :unviewed
    state :confirmed
    state :declined
    state :removed
    state :unavailable
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
    event :avail do
      transition all => :unviewed
    end
    event :unavail do
      transition all => :unavailable
    end
    event :restore do
      transition removed: :unviewed
    end
    event :state_renew do
      transition all => :unviewed
    end
    event :set_corrupted_email do
      transition all => :corrupted_email
    end
  end

  state_machine :member_state, initial: :unviewed, namespace: :member do
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

  include TagsHelper

  def has_auth_provider?(provider)
    authentications.map do |authentication|
      return authentication if authentication.provider == provider
    end
    nil
  end

  def visible_auth_of(provider)
    if attribute_accesses.where(member_attribute: provider, access: :visible).any?
      authentications.where(provider: provider).first
    end
  end

  def has_confession?(nomination)
    confessions.where(nomination: nomination, state: :confirmed).any?
  end

  def has_merit?(nomination)
    merits.where(nomination: nomination, state: :active).any?
  end

  include GenderHelper

  #FIXME try fix active form
  after_save :remove_empty_positions

  include PgSearch
  pg_search_scope :search_everywhere, against: [:email, :first_name, :last_name, :patronymic, :motto, :ticket, :mobile_phone, :home_adress, :municipality, :locality, :experience, :want_to_do, :school ]

  def is_header?
    Team.where(member_id: id).any?
  end

  def in_contact_list?
    positions.current_positions.any? && teams.any?
  end

  def has_permission_to?(action, type)
    Organization::Permissions.send(type)[action].map(&:id).include? self.id
  end

  def is_honorable?
    merits.where(nomination: :first_degree).any?
  end

  #FIXME because STI
  def admin_comments
    @admin_comments ||= Comment.where(comment_type: :admin, record_id: self.id, record_type: self.type)
  end

  private

  def remove_empty_positions
    registrations.where(user_id: nil).map &:destroy
  end
end
