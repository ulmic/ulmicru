class Team::Committee < Team
  belongs_to :project, polymorphic: true

  validates :title, presence: true
end
