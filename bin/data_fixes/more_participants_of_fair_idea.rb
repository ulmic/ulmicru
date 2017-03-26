fair_idea_id = ActivityLines::Lider::YaLider::Stage.find(3).contest.fair_idea.id
ActivityLines::Lider::YaLider::Stage.find(3).participants.where(state: :active).each do |p|
  ::Event::Registration.create(user_id: p.user_id, event_id: fair_idea_id)
end
