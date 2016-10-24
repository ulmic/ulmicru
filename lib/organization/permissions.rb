module Organization
  module Permissions
    class << self
      include Organization::PeopleHelper

      def news
        { need_to_review: (press_center_lead + departaments_curators + User.tech_admins).uniq }
      end

      def member
        { need_to_review: User.tech_admins }
      end

      def questionary
        { need_to_review: (corporative_lead + deputy_corporative_lead + User.tech_admins).uniq }
      end

      def event
        { need_to_review: (departaments_curators + User.tech_admins).uniq }
      end

      def feedback
        { need_to_review: User.tech_admins }
      end

      def comment
        { need_to_review: (press_center_lead + departaments_curators + corporative_lead + deputy_corporative_lead + User.tech_admins).uniq }
      end

      def article
        { need_to_review: (press_center_lead + User.tech_admins).uniq }
      end

      def position
        { need_to_review: (departaments_curators + corporative_lead + deputy_corporative_lead + User.tech_admins).uniq }
      end

      def team
        { need_to_review: (departaments_curators + corporative_lead + deputy_corporative_lead + User.tech_admins).uniq }
      end
    end
  end
end
