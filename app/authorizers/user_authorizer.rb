class UserAuthorizer < ApplicationAuthorizer
  def self.creatable_by?(user)
    user.role.admin?
  end
  def self.updatable_by?(user)
    user.role.admin? || user.id == resource.id
  end
  def self.deletable_by?(user)
    user.role.admin? || user.id == resource.id
  end
end
