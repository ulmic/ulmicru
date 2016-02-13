class Delivery::Campaign < ActiveRecord::Base
  has_many :audiences, class_name: 'Delivery::Audience'

  validates :title, presence: true
  validates :body, presence: true
  validates :image, presence: true
  validates :creator_id, presence: true
  validates :mailing_date, presence: true
end
