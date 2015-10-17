class Web::RemindPasswordsController < Web::ApplicationController
  def index
    byebug
    @user_form = UserForm.new_with_model
  end

  def create
    @user_form = UserForm.find_with_model_by email: params[:user][:email]
    if @user_form.model
      byebug
      user = @user_form.model
      if user.can_reset_password?
        user.generate_token
        user.save!
        # TODO replace to observers
        send_notification @user_form.model, @user_form.model, :remind_password
        redirect_to root_path
      else
        @user_form = @user_form.becomes! User
        render :index
      end
    else
      render :index
    end
  end
end
