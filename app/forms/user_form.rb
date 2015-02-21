class UserForm < ActionForm::Base
  self.main_model = :user

  attributes :email, :password, :role
end
