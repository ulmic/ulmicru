class ActivityLines::Lider::YaLider::EventForm < ApplicationReform
  properties :participant_id, :event_id

  collection :fields, populate_if_empty: ::ActivityLines::Lider::YaLider::EventField do
    properties :value, :event_id, :title, :field_type

    validates :value, presence: true
    validates :title, presence: true
    validates :event_id, presence: true
  end

  def build_values!
    titles = ::ActivityLines::Lider::YaLider::ParticipantField.title.values
    titles.each do |title|
      fields << model.fields.build(title: title)
    end
  end
end
