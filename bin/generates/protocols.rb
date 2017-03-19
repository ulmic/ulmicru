require "#{Rails.root}/lib/russian_cases"
include RussianCases

departaments_headers_pos = Position.where('title LIKE \'Руководитель местного отделения%\'')
departaments_headers_pos.each do |pos|
  Protocol.create! title: "Переизбрание #{pos.title.gsub('Руководитель', 'руководителя')}"
end
primaries_headers_pos = Position.where('title LIKE \'Руководитель первичной организации%\'')
primaries_headers_pos.each do |pos|
  Protocol.create! title: "Переизбрание #{pos.title.gsub('Руководитель', 'руководителя')}"
end
Team::Departament.find_each do |team|
  Protocol.create! title: "Открытие местного отделения МИЦ в #{instrumental(team.municipality)}", team_id: team.id
end
Team::Primary.find_each do |team|
  departament = Team.find team.team_id
  Protocol.create! title: "Открытие первичной организации местного отделения МИЦ в #{instrumental(departament.municipality)} в #{team.school}", team_id: team.id
end
