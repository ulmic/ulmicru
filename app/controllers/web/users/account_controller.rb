# -*- coding: utf-8 -*-
class Web::Users::AccountController < Web::Users::ApplicationController
  def index
    @user = current_user
    if @user.is_member?
      @member_form = MemberForm.find_with_model current_user.id
    end
    @authentications = current_user.authentications
    @teams = Team.active.visible.decorate
  end

  def update
    #FIXME more elegant solution
    model_name = :user
    [:member, :questionary].each do |name|
      model_name = name if params[name]
    end
    model = model_name.to_s.camelize.constantize
    model_form = "#{model_name.to_s.camelize}Form".constantize
    @user = model.find params[:id]
    @user_form = model_form.new @user
    old_email = @user.email
    @user_form.submit params[model_name]
    if @user_form.save
      redirect_to account_path
    else
      redirect_to account_path
    end
  end
end
