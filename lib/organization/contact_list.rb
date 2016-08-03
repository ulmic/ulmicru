module Organization
  module ContactList
    def self.list
      teams.reduce([]) do |members, team|
        members += MemberDecorator.decorate_collection(team.members.includes(:positions).map do |member|
          member if member.positions.current_positions.any?
        end.compact)
      end.uniq
    end

    private

    class << self
      include Organization::Teams

      def teams
        [ presidium, area_headers ] + Team::Departament.presented
      end
    end
  end
end
