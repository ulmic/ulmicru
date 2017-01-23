class Team::Committee < Team
  belongs_to :project, polymorphic: true

  extend Enumerize
  enumerize :project_type, in: [ 'ActivityLines::Lider::YaLider' ]
end
