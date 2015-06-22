module Web::ArticlesHelper
  include HistoryHelper

  def link_to_article_member_path(member, short_name = nil)
    if article_member_path member
      if short_name
        content_tag :a, short_name, href: article_member_path(member)
      else
        content_tag :a, member.short_name, href: article_member_path(member)
      end
    else
      short_name ? short_name : member.short_name
    end
  end

  def article_member_path(member)
    member.confirmed? ? member_path(member.ticket) : nil
  end

  def active_member_class(member)
    'active' if member.confirmed?
  end

  def article_team_path(team, link_title = nil)
    if team.active?
      if link_title
        content_tag :a, link_title, href: team_path(team)
      else
        content_tag :a, team.full_title, href: team_path(team)
      end
    else
    end
  end
end
