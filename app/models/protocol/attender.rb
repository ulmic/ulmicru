class Protocol::Attender < ActiveRecord::Base
  belongs_to :protocol
  belongs_to :member
end
