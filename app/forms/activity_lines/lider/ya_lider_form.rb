class ActivityLines::Lider::YaLiderForm < ApplicationReform
  properties :contest_year, :contest_number, :provision, :fair_idea_id

  validates :contest_year, presence: true
  validates :contest_number, presence: true

  collection :events, populate_if_empty: ::ActivityLines::Lider::EventsYaLider do
    properties :event_id, :ya_lider_id, :association_type
  end

  def build_fair_idea!
    unless events.map(&:association_type).include? 'fair_idea'
      events << model.events.build(association_type: :fair_idea)
    end
  end
end
