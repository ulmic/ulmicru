class Tag < ActiveRecord::Base
  belongs_to :record, polymorphic: true
  belongs_to :target, polymorphic: true

  validates :record_id, presence: true
  validates :record_type, presence: true

  extend Enumerize
  enumerize :record_type, in: [ :article, :news ]
  enumerize :target_type, in: [ :activity_line, :event, :member, :team ]
end
