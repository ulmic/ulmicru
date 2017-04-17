class View < ActiveRecord::Base
  belongs_to :record, polymorphic: true
  belongs_to :user

  extend Enumerize
  enumerize :record_type, in: [ 'News', 'Article', 'Member', 'Event' ]
end
