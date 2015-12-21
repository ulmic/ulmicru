class EventDecorator < ApplicationDecorator
  delegate_all

  def full_duration
    if begin_date.day == end_date.day && begin_date.month == end_date.month && begin_date.year == end_date.year
      "#{I18n.l(begin_date, format: '%d %b %Y')} #{begin_date.strftime('%H:%m')} - #{end_date.strftime('%H:%m')}"
    else
      "#{I18n.l(begin_date, format: '%d %b %Y %H:%m')} - #{I18n.l(end_date, format: '%d %b %Y %H:%m')}"
    end
  end

  def full_date_duration
    if begin_date.to_date == end_date.to_date
      "#{I18n.l(begin_date, format: '%d %b %Y')} #{begin_date.strftime('%H:%M')} - #{end_date.strftime('%H:%M')}"
    else
      "#{I18n.l(begin_date, format: '%d %b %Y')} - #{I18n.l(end_date, format: '%d %b %Y')}"
    end
  end

  def lead
    "#{object.description.first(150)}..."
  end

  def strip_tags_description
    strip_tags(object.description).html_safe
  end

  def name
    object.title
  end

  include Places

  def place_link_to_4sq
    @client ||= Places::FoursquareClient.new
    venue = @client.venue_by_id object.place
    h.content_tag :a, href: venue[:canonicalUrl],
                      target: '_blank' do
      venue[:name]
    end
  end

  def place_name
    @client ||= Places::FoursquareClient.new
    venue = @client.venue_by_id object.place
    venue[:name]
  end

  def organizer_link
    if object.organizer_type == 'Member'
      h.content_tag :a, href: member_path(object.organizer.ticket) do
        object.organizer.decorate.short_name
      end
    elsif object.organizer_type == 'Team'
      #h.content_tag :a, href: team_path(object.organizer_id) do
      object.organizer.decorate.full_title
      #end
    end
  end
end
