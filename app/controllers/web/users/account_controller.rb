# -*- coding: utf-8 -*-
class Web::Users::AccountController < Web::Users::ApplicationController
  def index
    case current_user.questionary_state
    when 'not_existed', 'done'
      @user = current_user
      if @user.is_member?
        @member_form = MemberForm.find_with_model current_user.id
      end
      @authentications = current_user.authentications
      @subscriptions = current_user.subscriptions
      @teams = Team.active.visible.decorate
    when 'step_1'
      redirect_to new_join_path(step: 1)
    when 'step_2'
      redirect_to new_join_path(step: 2)
    end
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
