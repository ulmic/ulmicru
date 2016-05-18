module Web::Admin::UsersHelper
  def roles_without_tech_admin
    User.role.values.except('tech_admin').reduce({}) do |hash, value|
      hash.merge! t("enumerize.user.role.#{value}") => value
    end 
  end
end
