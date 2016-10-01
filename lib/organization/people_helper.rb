module Organization
  module PeopleHelper
    def press_center_lead
      Position.current_positions.where(title: 'Руководитель пресс-центра').first.member
    end

    def corporative_lead
      Position.current_positions.where(title: 'Руководитель корпоративных проектов').first.member
    end

    def deputy_corporative_lead
      Position.current_positions.where(title: 'Заместитель руководителя корпоративных проектов').first.member
    end
  end
end
