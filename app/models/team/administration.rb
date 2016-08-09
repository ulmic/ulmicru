class Team::Administration < Team
  validates :title, presence: true

  def is_presidium?
    title == 'Президиум'
  end
end
