module Organization
  module Permissions
    class << self
      include Organization::PeopleHelper
      include Organization::Teams

      def news
        { 
          review: (press_center_lead + departaments_curators + User.tech_admins).uniq,
          index: (departaments_headers + deputy_departaments_headers + primaries_headers + User.tech_admins + current_ya_lider_committee).uniq,
          new: (departaments_headers + deputy_departaments_headers + primaries_headers + User.tech_admins + current_ya_lider_committee).uniq,
          create: (departaments_headers + deputy_departaments_headers + primaries_headers + User.tech_admins + current_ya_lider_committee).uniq,
          edit: (departaments_headers + deputy_departaments_headers + primaries_headers + User.tech_admins + current_ya_lider_committee).uniq,
          update: (departaments_headers + deputy_departaments_headers + primaries_headers + User.tech_admins + current_ya_lider_committee).uniq
        }
      end

      def member
        { 
          review: User.tech_admins
        }
      end

      def questionary
        { 
          review: (corporative_lead + deputy_corporative_lead + User.tech_admins + corporative_curators).uniq,
          show: (corporative_lead + deputy_corporative_lead + User.tech_admins + corporative_curators).uniq,
          index: (corporative_lead + deputy_corporative_lead + User.tech_admins + corporative_curators).uniq
        }
      end

      def event
        { 
          review: (departaments_curators + User.tech_admins).uniq,
          index: (departaments_headers + deputy_departaments_headers + primaries_headers + User.tech_admins + current_ya_lider_committee).uniq,
          new: (departaments_headers + deputy_departaments_headers + primaries_headers + User.tech_admins + current_ya_lider_committee).uniq,
          create: (departaments_headers + deputy_departaments_headers + primaries_headers + User.tech_admins + current_ya_lider_committee).uniq,
          edit: (departaments_headers + deputy_departaments_headers + primaries_headers + User.tech_admins + current_ya_lider_committee).uniq,
          update: (departaments_headers + deputy_departaments_headers + primaries_headers + User.tech_admins + current_ya_lider_committee).uniq
        }
      end

      def feedback
        { 
          review: User.tech_admins
        }
      end

      def comment
        { 
          review: (press_center_lead + departaments_curators + corporative_lead + deputy_corporative_lead + User.tech_admins).uniq
        }
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

      def activity_lines_corporative_online_conference_question
        { review: (area_headers.users + User.tech_admins).uniq }
      end

      def confession
        { review: (corporative_lead + User.tech_admins).uniq }
      end

      def activity_lines_lider_ya_lider
        { show: (lider_lead + User.tech_admins).uniq }
      end

      def letter
        {
          index: departaments_headers + primaries_headers,
          new: departaments_headers + primaries_headers,
          create: departaments_headers + primaries_headers,
          edit: departaments_headers + primaries_headers,
          update: departaments_headers + primaries_headers
        }
      end

      def welcome
        { see: (departaments_headers + deputy_departaments_headers + primaries_headers + current_ya_lider_committee).uniq }
      end

      def place
        { 
          index: departaments_headers + deputy_departaments_headers + primaries_headers,
          new: departaments_headers + deputy_departaments_headers + primaries_headers,
          create: (departaments_headers + deputy_departaments_headers + primaries_headers + User.tech_admins + User.admins + User.authors).uniq,
          edit: departaments_headers + deputy_departaments_headers + primaries_headers,
          update: departaments_headers + deputy_departaments_headers + primaries_headers,
          review: User.tech_admins
        }
      end

      def activity_lines_lider_ya_lider
        {
          index: (lider_lead + current_ya_lider_committee + User.tech_admins).uniq,
          show: (lider_lead + current_ya_lider_committee + User.tech_admins).uniq,
          new: (lider_lead + current_ya_lider_committee + User.tech_admins).uniq,
          create: (lider_lead + current_ya_lider_committee + User.tech_admins).uniq,
          edit: (lider_lead + current_ya_lider_committee + User.tech_admins).uniq,
          update: (lider_lead + current_ya_lider_committee + User.tech_admins.uniq)
        }
      end

      def activity_lines_lider_ya_lider_stage
        {
          index: (lider_lead + current_ya_lider_committee + User.tech_admins).uniq,
          show: (lider_lead + current_ya_lider_committee + User.tech_admins).uniq,
          new: (lider_lead + current_ya_lider_committee + User.tech_admins).uniq,
          create: (lider_lead + current_ya_lider_committee + User.tech_admins).uniq,
          edit: (lider_lead + current_ya_lider_committee + User.tech_admins).uniq,
          update: (lider_lead + current_ya_lider_committee + User.tech_admins).uniq
        }
      end

      def activity_lines_lider_ya_lider_participation
        {
          index: (lider_lead + current_ya_lider_committee + User.tech_admins).uniq,
          show: (lider_lead + current_ya_lider_committee + User.tech_admins).uniq,
          new: (lider_lead + current_ya_lider_committee + User.tech_admins).uniq,
          create: (lider_lead + current_ya_lider_committee + User.tech_admins).uniq,
          edit: (lider_lead + current_ya_lider_committee + User.tech_admins).uniq,
          update: (lider_lead + current_ya_lider_committee + User.tech_admins).uniq
        }
      end

      def activity_lines_lider_ya_lider_participant
        {
          index: (lider_lead + current_ya_lider_committee + User.tech_admins),
          show: (lider_lead + current_ya_lider_committee + User.tech_admins).uniq,
          new: (lider_lead + current_ya_lider_committee + User.tech_admins).uniq,
          create: (lider_lead + current_ya_lider_committee + User.tech_admins).uniq,
          edit: (lider_lead + current_ya_lider_committee + User.tech_admins).uniq,
          update: (lider_lead + current_ya_lider_committee + User.tech_admins).uniq
        }
      end

      def protocol
        { index: (departaments_curators + krk.users + presidium.users).uniq }
      end
    end
  end
end
