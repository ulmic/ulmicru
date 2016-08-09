module Organization
  module Teams
    include PositionList

    def presidium
      @presidium ||= Team.includes(:users).find_by_title 'Президиум'
    end

    def area_headers
      @area_headers ||= Team.find_by_title 'Руководители областных программ и проектов МИЦ'
    end

    def team_positions(team)
      positions_structure ||= YAML.load_file("#{Rails.root}/lib/yaml/positions.yml").with_indifferent_access
      team_positions = positions_structure[:positions][:team].map do |position|
        if position.is_a? String
          "#{position.mb_chars.capitalize.to_s} #{team.full_title(:genitive)}"
        elsif position.is_a? Hash
          deputy = position[:deputy]
          deputy.map do |name|
            "Заместитель #{genitive(name)} #{team.full_title(:genitive)}"
          end
        end
      end
      team_type_structure = 'team/departament' if team.is_a? Team::Departament
      team_type_structure = 'team/primary' if team.is_a? Team::Primary
      if team_type_structure.present?
        structure = positions_structure[:positions][team_type_structure]
        if structure[:activity_line].present?
          structure[:activity_line].each do |p|
            team_positions += ActivityLine.active.has_curators.decorate.map do |a_l|
              "#{p.mb_chars.capitalize.to_s} #{a_l.full_title(:genitive)} в #{team.full_title(:dative)}"
            end
          end
        end
      end
      order_positions team_positions.flatten
    end

    def positions_associate_with_team(positions, team)
      positions.where title: team_positions(team)
    end
  end
end
