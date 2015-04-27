module Web::ArticlesHelper
  def article_member_path(member, short_name = nil)
    if member.confirmed?
      if short_name
        content_tag(link_to, short_name, member_path(member.ticket))
      else
        content_tag(link_to, member.short_name, member_path(member.ticket))
      end
    else
      short_name ? short_name : member.short_name
    end
  end

  def article_team_path(team, link_title = nil)
    if team.active?
      if link_title
        content_tag link_to, link_title, team_path(team)
      else
        content_tag link_to, team.full_title, team_path(team)
      end
    else
    end
  end
end
