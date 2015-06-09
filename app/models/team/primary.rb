class Team::Primary < Team
  belongs_to :departament

  validates :school, presence: true
  validates :team_id, presence: true

  include Schools

  enumerize :school, in: Schools.list
end
