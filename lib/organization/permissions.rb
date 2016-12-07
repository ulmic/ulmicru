module Organization
  module Permissions
    class << self
      include Organization::PeopleHelper
      include Organization::Teams

      def news
        { review: (press_center_lead + departaments_curators + User.tech_admins).uniq }
      end

      def member
        { review: User.tech_admins }
      end

      def questionary
        { review: (corporative_lead + deputy_corporative_lead + User.tech_admins).uniq }
      end

      def event
        { review: (departaments_curators + User.tech_admins).uniq }
      end

      def feedback
        { review: User.tech_admins }
      end

      def comment
        { review: (press_center_lead + departaments_curators + corporative_lead + deputy_corporative_lead + User.tech_admins).uniq }
      end

      def article
        { review: (press_center_lead + User.tech_admins).uniq }
      end

      def position
        { review: (departaments_curators + corporative_lead + deputy_corporative_lead + User.tech_admins).uniq }
      end

      def team
        { review: (departaments_curators + corporative_lead + deputy_corporative_lead + User.tech_admins).uniq }
      end

      def activity_lines_corporative_confession
        { review: (presidium.users + vice_chairmen + User.tech_admins + corporative_lead).uniq }
      end
    end
  end
end
