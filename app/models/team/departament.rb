class Team::Departament < Team
  validates :municipality, presence: true

  extend Enumerize
  enumerize :municipality, in: Municipalities.list, default: Municipalities.list.first
end
