# -*- coding: utf-8 -*-
class Web::Users::AccountController < Web::Users::ApplicationController
  def index
    @user = current_user
    if @user.is_member?
      # TODO мб лучше @member_form = MemberForm.find_with_model(current_user.id)
      @member = Member.find current_user.id
      @member_form = MemberForm.new @member
    end
    @authentications = current_user.authentications
  end

  def update
    if params[:user]
      @user = User.find params[:id]
      @user_form = UserForm.new @user
      @user_form.submit params[:user]
      if @user_form.save
        redirect_to account_path
      else
        redirect_to account_path
      end
    elsif params[:member]
      @member = Member.find params[:id]
      @member_form = MemberForm.new @member
      @member_form.submit params[:member]
      if @member_form.save
        redirect_to account_path
      else
        redirect_to account_path
      end
    end
  end
end
