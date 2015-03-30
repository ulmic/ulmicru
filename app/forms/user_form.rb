class UserForm < ApplicationForm
  self.main_model = :user

  attributes :email, :role, :first_name, :last_name, :patronymic, required: true
  attributes :password
end
