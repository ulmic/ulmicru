module Web::Users::AccountHelper
  include Accesses

  def attributes_need_access
    Accesses.attributes
  end

  #FIXME убрать запросы из хелперов
  def attribute_access(attribute, member)
    access = AttributeAccess.where(member_attribute: attribute, member_id: member.id).first
    access.access.visible? if access
  end
end
