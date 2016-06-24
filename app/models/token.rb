class Token < ActiveRecord::Base
  belongs_to :record, polymorphic: true
end
