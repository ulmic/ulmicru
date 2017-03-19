FactoryGirl.define do
  factory :protocol do
    title { generate :string }
    team_id { Team.last.present? ? Team.last.id : create(:team).id }
    document_id { Document.last.present? ? Document.last.id : create(:document).id }
    scan { generate :image_as_file }
    state { Protocol.state_machines[:state].states.map(&:name).first.to_s }
  end
end
