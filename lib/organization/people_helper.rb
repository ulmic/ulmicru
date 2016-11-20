module Organization
  module PeopleHelper
    def press_center_lead
      Position.current_positions.where(title: 'Руководитель пресс-центра').map &:member
    end

    def corporative_lead
      Position.current_positions.where(title: 'Руководитель корпоративных проектов').map &:member
    end

    def deputy_corporative_lead
      Position.current_positions.where(title: 'Заместитель руководителя корпоративных проектов').map &:member
    end

    def departaments_curators
      Position.current_positions.where(title: 'Куратор местных отделений').map &:member
    end

    def vice_chairmen
      @vice_chairmen ||= Member.where(id: Position.current_positions.where(title: 'Заместитель председателя').map(&:id))
    end
  end
end
