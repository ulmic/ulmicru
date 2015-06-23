class UserForm < ApplicationForm
  self.main_model = :user

  attributes :role, :first_name, :last_name, required: true
  attributes :patronymic, :password, :email
end
