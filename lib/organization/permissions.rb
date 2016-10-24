module Organization::Permissions
  class << self
    include Organization::PeopleHelper

    def news_confirm_members
      press_center_lead + departaments_curators
    end
  end
end
