class Protocol::Absent < ActiveRecord::Base
  belongs_to :member
  belongs_to :protocol
end
