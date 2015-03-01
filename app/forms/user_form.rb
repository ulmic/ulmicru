class UserForm < ApplicationForm
  self.main_model = :user

  attributes :email, :password, :role, :first_name, :last_name, :patronymic
end
