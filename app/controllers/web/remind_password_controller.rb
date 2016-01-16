class Web::RemindPasswordController < Web::ApplicationController
  def new
    @user_form = UserForm.new_with_model
  end

  def create
    @user_form = UserForm.find_with_model_by email: params[:user][:email]

    if @user_form.model && @user_form.can_reset_password?
      user = @user_form.model
      user.generate_token
      user.save!

      # TODO replace to observers
      send_notification @user_form.model, @user_form.model, :remind_password

      flash[:remind_password_notification] = :remind_password_notification_sended
      redirect_to new_session_path
    else
      @user_form = UserForm.new_with_model email: params[:user][:email]
      render :new
    end
  end

  def edit
    @user_form = UserForm.find_with_model_by! token: params[:token]
    @token = params[:token]
  end

  def update
    @user_form = UserForm.find_with_model_by! token: params[:token]
    @user_form.submit params[:user] || params[:member] || params[:questionary]
    if @user_form.save
      redirect_to new_session_path
    else
      @token = params[:token]
      render :edit
    end
  end
end
