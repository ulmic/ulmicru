class Delivery::Campaign < ActiveRecord::Base
  has_many :audiences, class_name: 'Delivery::Audience'
  belongs_to :creator, class_name: 'Member'

  validates :title, presence: true
  validates :body, presence: true
  validates :image, presence: true
  validates :creator_id, presence: true
  validates :mailing_date, presence: true

  mount_uploader :image, PhotoUploader

  state_machine :state, initial: :ready do
    state :ready
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
  end

  include Delivery::CampaignScopes
  include PgSearch
  pg_search_scope :search_everywhere, against: [ :title, :body, :link, :mailing_date ]
end
