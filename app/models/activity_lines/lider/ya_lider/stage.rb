class ActivityLines::Lider::YaLider::Stage < ActiveRecord::Base
  belongs_to :ya_lider, class_name: 'ActivityLines::Lider::YaLider'

  validates :number, presence: true, uniqueness: { scope: :ya_lider_id }
end
