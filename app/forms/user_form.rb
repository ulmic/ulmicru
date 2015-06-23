class UserForm < ApplicationForm
  self.main_model = :user

  attributes :role, :email, :first_name, :last_name, required: true
  attributes :patronymic, :password
end
