class UserForm < ApplicationForm
  self.main_model = :user

  attributes :email, :password, :password_confirmation, :role, :first_name, :last_name
end
