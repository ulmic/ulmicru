module Organization
  module ContactList
    class ContactList::Team < Struct.new(:title, :members)
    end

    def self.list
      teams.reduce([]) do |arr, team|
        members = MemberDecorator.decorate_collection(team.members.includes(:positions).map do |member|
          member if member.positions.current_positions.any? && !arr.map(&:members).flatten.include?(member)
        end.compact)
        arr << ContactList::Team.new(team.decorate.full_title, members)
      end
    end

    private

    class << self
      include Organization::Teams

      def teams
        [ presidium, area_headers ] + ::Team::Departament.presented
      end
    end
  end
end
