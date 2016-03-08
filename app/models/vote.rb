class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :target, polymorphic: true

  validates :difference, presence: true
  validates :user_id, presence: true,
                      uniqueness: { scope: [ :target_id, :target_type ] }
  validates :target_id, presence: true
  validates :target_type, presence: true
end
