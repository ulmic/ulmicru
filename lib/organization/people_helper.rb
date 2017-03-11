module Organization
  module PeopleHelper
    def press_center_lead
      Position.current_positions.where(title: 'Руководитель пресс-центра').map &:member
    end

    def corporative_lead
      Position.current_positions.where(title: 'Руководитель корпоративных проектов').map &:member
    end

    def lider_lead
      Position.current_positions.where(title: 'Руководитель центральной программы «Лидер»').map &:member
    end

    def deputy_corporative_lead
      Position.current_positions.where(title: 'Заместитель руководителя корпоративных проектов').map &:member
    end

    def departaments_curators
      Position.current_positions.where(title: 'Куратор местных отделений').map &:member
    end

    def chairman
      @chairman ||= Member.where(id: Position.current_positions.where(title: 'Председатель').map(&:member_id))
    end

    def vice_chairmen
      @vice_chairmen ||= Member.where(id: Position.current_positions.where(title: 'Заместитель председателя').map(&:member_id))
    end

    def corporative_curators
      @corporative_curators ||= User.where(id: Position.current_positions.where('title LIKE \'Куратор корпоративных проектов%\'').map(&:member_id))
    end

    def departaments_headers
      @departaments_headers ||= User.where(id: Position.current_positions.where('title LIKE \'Руководитель местного отделения%\'').map(&:member_id))
    end

    def deputy_departaments_headers
      @deputy_departaments_headers ||= User.where(id: Position.current_positions.where('title LIKE \'Заместитель руководителя местного отделения%\'').map(&:member_id))
    end

    def primaries_headers
      @primaries_headers ||= User.where(id: Position.current_positions.where('title LIKE \'Руководитель первичной организации%\'').map(&:member_id))
    end
  end
end
