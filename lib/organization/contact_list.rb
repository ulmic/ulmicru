module Organization
  module ContactList
    class ContactList::Team < Struct.new(:title, :users)
    end

    def self.list
      teams.reduce([]) do |arr, team|
        members = team.users.decorate.map(&:main_current_position).compact.sort_by { |p| PositionList.list.index(p.title) }.map(&:member)
        members += team.users.without_current_positions if team.is_presidium?
        users = MemberDecorator.decorate_collection(members.map do |member|
          member if !arr.map(&:users).map(&:object).flatten.map(&:id).include?(member.id)
        end.compact)
        arr << ContactList::Team.new(team.decorate.full_title, users)
      end
    end

    private

    class << self
      include Organization::Teams

      def teams
        [ presidium, area_headers ] + ::Team::Departament.active + ::Team::Primary.presented
      end
    end
  end
end
