module Web::MembersHelper
  def members_hash(members)
    members_hash = {}
    members.each do |member|
      members_hash[member.select_presentation] = member.id
    end
    members_hash
  end

  def present_member_path(member)
    member.confirmed? ? member_path(member.ticket) : '#'
  end

  def present_link_class(member)
    member.confirmed? ? :link : ''
  end

  def attribute_visible?(accesses, attribute)
    attr_access = accesses.find_by_member_attribute attribute
    attr_access.access.visible? if attr_access
  end
end
