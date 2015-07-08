class Web::RemindPasswordsController < Web::ApplicationController
  def new
    @user_form = UserForm.new_with_model
  end

  def create
    @user_form = UserForm.new_with_model params[:user]
    if @user_form.valid?
      user = @form.user
      if user.can_reset_password?
        user.generate_reset_password_token
        user.save!
        # TODO replace to observers
        send_notification @user_form.model, @user_form.model, :remind_password

        redirect_to root_path
      end
      # else f(:error)
    else
      render :new
    end
  end
end
