class ActivityLines::Corporative::Argument < ActiveRecord::Base
  belongs_to :member
  belongs_to :confession

  validates :argument_type, presence: true
  validates :text, presence: true
  validates :confession_id, presence: true

  extend Enumerize
  enumerize :argument_type, in: [ :reason, :honors, :out_ulmic_honors, :hobby ]

  after_create :update_member_id

  def build_arguments_for_petition
    self.argument_type.values.each do |a_type|
      arguments.build argument_type: a_type
    end
  end

  private

  def update_member_id
    update member_id: current_user.id
  end
end
