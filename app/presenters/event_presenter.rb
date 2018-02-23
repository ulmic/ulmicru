class EventPresenter < ApplicationPresenter
  attributes :title, :description, :main_photo, :creator_id, :begin_date, :end_date, :state, :organizer_id, :organizer_type, :activity_line_id

  has_many :places, serializer: ::PlacePresenter
  has_many :registrations, serializer: ::RegistrationPresenter

  def begin_date
    object.begin_date.iso8601
  end

  def end_date
    object.end_date.iso8601
  end

  def main_photo
    object.main_photo.url
  end
end
