class TeamForm < ApplicationForm
  self.main_model = :team

  attributes :title, :member_id, :description
end
