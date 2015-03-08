module Web::Users::AccountHelper
  include Accesses

  def attributes_need_access
    Accesses.attributes
  end
end
