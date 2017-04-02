class ActivityLines::Lider::YaLider::EventForm < ApplicationReform
  properties :participant_id, :event_id

  collection :fields, populate_if_empty: ::ActivityLines::Lider::YaLider::EventField do
    properties :value, :event_id, :title, :field_type

    validates :value, presence: true
    validates :title, presence: true
  end

  def anounce_titles
    [ 'anticipated_participants_count' ]
  end

  def report_titles
    ::ActivityLines::Lider::YaLider::EventField.title.values - anounce_titles
  end

  def build_values!(type)
    titles = case type
             when :anounce 
               [:anticipated_participants_count]
             when :report
               ::ActivityLines::Lider::YaLider::EventField.title.values - [ 'anticipated_participants_count' ]
             end
    titles.each do |title|
      fields << model.fields.build(title: title)
    end
  end
end
