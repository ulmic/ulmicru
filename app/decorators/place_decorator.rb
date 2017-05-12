class PlaceDecorator < ApplicationDecorator
  delegate_all

  def coordinates
    "#{object.latitude} #{object.longitude}"
  end

  def name
    object.title
  end

  def service_icon
    return fa_icon(:foursquare) if url.include? 'foursquare'
    return fa_icon(:google) if url.include? 'google'
    return 'Я' if url.include? 'yandex'
  end
end
