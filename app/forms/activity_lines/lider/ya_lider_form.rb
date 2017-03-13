class ActivityLines::Lider::YaLiderForm < ApplicationReform
  properties :contest_year, :contest_number, :provision, :fair_idea_id

  validates :contest_year, presence: true
  validates :contest_number, presence: true

  collection :events do
    properties :event_id, :activity_lines_lider_ya_lider_id, :association_type
  end

  def build_fair_idea!
    activity_lines_lider_events_ya_liders << model.activity_lines_lider_events_ya_liders.build(association_type: :fair_idea)
  end
end
