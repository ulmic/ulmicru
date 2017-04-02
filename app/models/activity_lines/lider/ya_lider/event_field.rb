class ActivityLines::Lider::YaLider::EventField < ActiveRecord::Base
  belongs_to :event, class_name: 'ActivityLines::Lider::YaLider::ParticipantEvent'

  extend Enumerize
  enumerize :title, in: [ :anticipated_participants_count, :goal, :tasks, :pluses, :minuses, :likes_as_event_participant, :changes_events,
    :team_work, :resources, :quality, :main_idea, :photo_album, :video, :smi, :partners]

  enumerize :field_type, in: [ :text, :file ]
end
