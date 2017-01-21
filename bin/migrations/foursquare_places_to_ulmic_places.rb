count = Event.count
Event.where.not(place: '').find_each.with_index do |event, index|
  place = Place.where(foursquare_uid: event.place).first
  if place.present?
    event.places << place
    event.save
  else
    @client ||= Places::FoursquareClient.new
    venue = @client.venue_by_id event.place
    Place.create! title: venue[:name], description: venue[:description],  foursquare_uid: event.place,
      location: venue[:location], url: venue[:canonicalUrl]
  end
  print "#{index} of #{count}\r"
end
