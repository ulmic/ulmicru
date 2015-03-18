class Authentication < ActiveRecord::Base
  validates :uid, presence: true
  validates :provider, presence: true
  validates :user_id, presence: true

  belongs_to :user

  extend Enumerize
  enumerize :provider, in: SocialNetworks.list
end
