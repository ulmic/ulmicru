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

  MEMBER_TAG = /%\{.*\}/

  # FIXME queries from helper!!!

  def member_tags_helper(content)
    if includes_member_tags? content
      member_ids = []
      if content.is_a? Array
        content.each do |text|
          text.scan(/%{([0-9]+)}/).each do |id|
            member_ids << id[0].to_i
          end
        end
      else
        content.scan(/%{([0-9]+)}/).each do |id|
          member_ids << id[0].to_i
        end
      end
      Member.confirmed.where ticket: member_ids
    end
  end

  def includes_member_tags?(content)
    if content.is_a? Array
      content.each do |text|
        return true if text.match MEMBER_TAG
      end
      return false
    else
      content.match MEMBER_TAG
    end
  end

  def strip_member_tags(text)
    if text.include? '{'
      text.gsub MEMBER_TAG, ''
    else
      text
    end
  end
end
