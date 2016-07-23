module Organization
  module PeopleHelper
    def press_center_lead
      User.first.decorate
    end
  end
end
