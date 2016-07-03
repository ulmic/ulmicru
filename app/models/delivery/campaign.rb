class Delivery::Campaign < ActiveRecord::Base
  has_many :audiences, class_name: 'Delivery::Audience'
  belongs_to :creator, class_name: 'Member'

  validates :title, presence: true
  validates :body, presence: true
  validates :image, presence: true
  validates :creator_id, presence: true

  accepts_nested_attributes_for :audiences

  mount_uploader :image, PhotoUploader

  state_machine :state, initial: :ready do
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
  end

  include PgSearch
  pg_search_scope :search_everywhere, against: [ :title, :body, :link, :mailing_date ]

  def fill_audiences?
    audiences.any? && audiences.first.audience_type.in?([ 'users', 'contacts_emails' ])
  end

  def contacts
    audiences.reduce([]) do |arr, audience|
      arr += audience.contacts
    end
  end
end
