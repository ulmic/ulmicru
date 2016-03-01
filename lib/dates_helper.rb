#FIXME it will fixed on https://trello.com/c/MqBhJhpc/407-configus-dates ticket
module DatesHelper
  CONFESSION_DATES = configus.dates.activity_lines.corporative.confession if configus.present?

  def submissions_petitions_during?
    submissions_petitions_begins? && !submissions_petitions_ends?
  end

  def submissions_petitions_begins?
    DateTime.now > CONFESSION_DATES.begining_submissions_petitions
  end

  def submissions_petitions_ends?
    DateTime.now > CONFESSION_DATES.ending_submissions_petitions
  end

  def voting_petitions_during?
    voting_petitions_begins? && !voting_petitions_ends?
  end

  def voting_petitions_begins?
    DateTime.now > CONFESSION_DATES.begining_voting
  end

  def voting_petitions_ends?
    DateTime.now > CONFESSION_DATES.ending_voting
  end

  def current_confession_year
    CONFESSION_DATES.begining_submissions_petitions.year
  end

  def confession_events_during?
    submissions_petitions_begins? && !voting_petitions_ends?
  end
end
