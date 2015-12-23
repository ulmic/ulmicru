class Members::Corporative::PetitionForm < ApplicationForm
  def initialize
    self.main_model = 'activity_lines/corporative/confession'
    super
  end

  attributes :member_id, :nomination, :creator_id
end
