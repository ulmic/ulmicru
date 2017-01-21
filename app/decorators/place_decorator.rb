class PlaceDecorator < ApplicationDecorator
  delegate_all

  def self.collections
    [:active, :removed]
  end

  def coordinates
    "#{object.latitude} #{object.longitude}"
  end
end
