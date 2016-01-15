class VoteForm < ApplicationReform
  properties :user_id, :target_id, :target_type, :difference

  validates :user_id, presence: true
  validates :target_id, presence: true
  validates :target_type, presence: true
  validates :difference, presence: true
end
