module Organization
  module Permissions
    class << self
      include Organization::PeopleHelper

      def news
        { need_to_review: (press_center_lead + departaments_curators + User.tech_admins).uniq }
      end
    end
  end
end
