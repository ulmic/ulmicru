class ActivityLines::Lider::YaLider::ParticipantField < ActiveRecord::Base
  belongs_to :participant

  extend Enumerize
  enumerize :title, in: [ :reason, :what_is_win_for_you, :quality, :if_i_have_one_million, :one_dream, :hobby, :life_plans, :esse ]
  enumerize :field_type, in: [ :text, :file ]
end
