class PlaceForm < ApplicationReform
  properties :title, :description, :foursquare_uid, :longitude, :latitude, :url

  validates :title, presence: true
  validates :description, presence: true
  validates :url, presence: true
end
