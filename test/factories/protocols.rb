FactoryGirl.define do
  factory :protocol do
    team_id { Team.last.present? ? Team.last.id : create(:team).id }
    scan { generate :image_as_file }
    state { Protocol.state_machines[:state].states.map(&:name).first.to_s }
    record_type 'Position'
    record_id { create(:position).id }
  end
end
