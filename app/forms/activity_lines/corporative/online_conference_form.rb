class ::ActivityLines::Corporative::OnlineConferenceForm < ApplicationReform
  properties :title, :date, :video_link, :state

  validates :title, presence: true
  validates :date, presence: true
  validates :video_link, presence: true
end
