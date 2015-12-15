class ActivityLines::Corporative::Argument < ActiveRecord::Base
  belongs_to :member
  belongs_to :confession

  validates :argument_type, presence: true
  validates :text, presence: true

  extend Enumerize
  enumerize :argument_type, in: [ :reason, :honors, :out_ulmic_honors, :hobby ]
end
