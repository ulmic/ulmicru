class Team::Departament < Team
  validates :municipality, presence: true

  enumerize :municipality, in: Municipalities.list, default: Municipalities.list.first
end
