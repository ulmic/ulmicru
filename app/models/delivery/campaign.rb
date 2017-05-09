class Delivery::Campaign < ActiveRecord::Base
  has_many :audiences, class_name: 'Delivery::Audience'
  has_many :receivers, class_name: 'Delivery::Receiver'
  belongs_to :creator, class_name: 'Member'

  include StateMachine::Scopes

  validates :title, presence: true
  validates :body, presence: true
  validates :image, presence: true
  validates :creator_id, presence: true

  accepts_nested_attributes_for :audiences

  mount_uploader :image, PhotoUploader

  state_machine :state, initial: :not_tested do
    state :not_tested
    state :test_failed
    state :ready
    state :during_mailing
    state :removed
    state :declined
    state :done

    event :get_ready do
      transition all => :ready
    end

    event :remove do
      transition all => :removed
    end

    event :decline do
      transition all => :declined
    end

    event :start_mailing do
      transition all => :during_mailing
    end

    event :make_done do
      transition all => :done
    end

    event :fail_test do
      transition all => :test_failed
    end
  end

  include PgSearch
  pg_search_scope :search_everywhere, against: [ :title, :body, :link, :mailing_date ]

  def fill_audiences?
    audiences.any? && audiences.first.audience_type.in?([ 'users', 'contacts_emails' ])
  end

  def fill_receivers!
    [User, Delivery::ContactEmail].each do |type|
      (contacts.select { |c| c.user_type == type }.map(&:id) - receivers.select { |r| r.user_type == type.to_s }.map(&:user_id)).each do |user_id|
        ::Delivery::Receiver.create! user_id: user_id, campaign_id: id, user_type: type
      end
    end
  end

  def contacts
    @contacts ||= audiences.reduce([]) do |arr, audience|
      arr += audience.contacts
    end.uniq
  end
end
