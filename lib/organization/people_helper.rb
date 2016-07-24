module Organization
  module PeopleHelper
    def press_center_lead
      Position.current_positions.where(title: 'Руководитель пресс-центра').first.member
    end
  end
end
