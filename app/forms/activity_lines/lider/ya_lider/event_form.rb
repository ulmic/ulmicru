class ActivityLines::Lider::YaLider::EventForm < ApplicationReform
  properties :participant_id, :event_id

  collection :fields, populate_if_empty: ::ActivityLines::Lider::YaLider::EventField do
    properties :value, :event_id, :title, :field_type

    validates :value, presence: true
    validates :title, presence: true
  end

  property :event, populate_if_empty: Event do
    properties :title, :description, :main_photo, :place_ids, :creator_id, :begin_date, :end_date, :activity_line_id, 
               :organizer_type, :organizer_id, required: true

    collection :registrations do
      properties :user_id, :event_id, :role
    end
  end

  def build_values!(type)
    titles = case type
             when :anounce 
               [:anticipated_participants_count]
             when :report
               ::ActivityLines::Lider::YaLider::ParticipantField.title.values - [ :anticipated_participants_count ]
             end
    titles.each do |title|
      fields << model.fields.build(title: title)
    end
  end
end
