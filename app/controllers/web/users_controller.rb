class Web::UsersController < Web::ApplicationController
  def new
    @user_form = UserForm.new_with_model
  end

  def create
    @user_form = UserForm.new_with_model
    @user_form.submit params[:user]
    if @user_form.save
      #TODO replace to observers
      send_notification @user_form.model, @user_form.model, :after_create

      sign_in @user_form.model
      redirect_to account_path
    else
      render action: :new
    end
  end
end
