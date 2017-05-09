class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :target, polymorphic: true

  validates :difference, presence: true
  validates :user_id, presence: true,
                      uniqueness: { scope: [ :target_id, :target_type ] }
  validates :target_id, presence: true
  validates :target_type, presence: true

  scope :likes, -> { where difference: 1 }
  scope :dislikes, -> { where difference: -1 }
  scope :from_members, -> { where user_id: Member.just_members.map(&:id) }
  scope :from_users, -> { where user_id: User.just_users.map(&:id)  }
end
