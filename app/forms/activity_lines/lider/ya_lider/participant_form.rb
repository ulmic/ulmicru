class ActivityLines::Lider::YaLider::ParticipantForm < ApplicationReform
  properties :contest_id, :user_id, :state

  validates :contest_id, presence: true
  validates :user_id, presence: true

  collection :fields, populate_if_empty: ::ActivityLines::Lider::YaLider::ParticipantField do
    properties :value, :participant_id, :title

    validates :value, presence: true
    validates :title, presence: true
    validates :participant_id, presence: true
  end

  def build_values!
    titles = ::ActivityLines::Lider::YaLider::ParticipantField.title.values
    titles.each do |title|
      fields << model.fields.build(title: title)
    end
  end
end
