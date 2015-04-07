class Tag < ActiveRecord::Base
  belongs_to :record, polymorphic: true
  belongs_to :target, polymorphic: true

  validates :record_id, presence: true
  validates :record_type, presence: true
  validates :tag_type, presence: true

  extend Enumerize
  enumerize :record_type, in: [ 'Article', 'News' ]
  enumerize :target_type, in: [ 'ActivityLine', 'Event', 'Member', 'Team' ]
  enumerize :tag_type, in: [ :string, :link ]
end
