class Delivery::Audience < ActiveRecord::Base
  validates :audience_type, presence: true
end
