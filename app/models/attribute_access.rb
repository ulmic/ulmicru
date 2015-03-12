class AttributeAccess < ActiveRecord::Base
  belongs_to :member

  validates :member_id, presence: true
  validates :member_attribute, presence: true
  validates :access, presence: true

  extend Enumerize
  enumerize :access, in: [ :visible, :hidden ], default: :hidden
end
