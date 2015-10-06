require 'securerandom'

class Web::RemindPasswordsController < Web::ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.where(email: params[:user][:email]).first
    if @user.present?
      @user.generate_token
      @user.save!
      # TODO replace to observers
      send_notification @user, @user, :remind_password

      redirect_to root_path
    else
      # else f(:error)
      render :new
    end
  end
end
