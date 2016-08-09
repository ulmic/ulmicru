module Organization
  module ContactList
    class ContactList::Team < Struct.new(:title, :users)
    end

    def self.list
      teams.reduce([]) do |arr, team|
        users = MemberDecorator.decorate_collection(team.users.order(:ticket).includes(:positions, :attribute_accesses).map do |member|
          member if member.positions.current_positions.any? && !arr.map(&:users).flatten.include?(member)
        end.compact)
        arr << ContactList::Team.new(team.decorate.full_title, users)
      end
    end

    private

    class << self
      include Organization::Teams

      def teams
        [ area_headers ] + ::Team::Departament.presented
      end
    end
  end
end
