class Web::UsersController < Web::ApplicationController
  def new
    @user_form = UserForm.new_with_model
  end

  def create
    @user_form = UserForm.new_with_model
    @user_form.submit params[:user]
    if check_exists_unavailable_member
      redirect_to account_path
    else
      if @user_form.save
        #TODO replace to observers
        #send_notification @user_form.model, @user_form.model, :after_create

        sign_in @user_form.model
        redirect_to account_path
      else
        render action: :new
      end
    end
  end

  private

  def check_exists_unavailable_member
    exists_member = Member.unavailable.find_by_email params[:user][:email]
    if exists_member
      exists_member.becomes! User
      User.find(exists_member.id).update type: nil
      User.find(exists_member.id).update state: :unviewed
      sign_in exists_member
    end
  end
end
