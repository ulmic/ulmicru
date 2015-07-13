# -*- coding: utf-8 -*-
module Concerns
  module AuthManagment
    def sign_in(user)
      session[:user_id] = user.id
    end

    def sign_out
      session[:user_id] = nil
    end

    def signed_in?
      current_user
    end

    def signed_as_admin?
      signed_in? && (current_user.role.admin? || current_user.role.author?)
    end

    def authenticate_admin!
      redirect_to not_found_page_path unless signed_as_admin?
    end

    def authenticate_user!
      redirect_to new_session_path unless signed_in?
    end

    def authenticate_confirmed_user!
      redirect_to account_path if current_user.unviewed? && request.fullpath != account_path
    end

    def authenticate_member!
      if signed_in?
        unless current_user.member.present?
          redirect_to new_session_path
        end
      else
        redirect_to new_session_path
      end
    end

    def current_user
      @_current_user ||= User.find_by(id: session[:user_id])
    end

    def required_basic_auth!
      authenticate_or_request_with_http_basic do |user, password|
        user == configus.basic_auth.username && password == configus.basic_auth.password
      end
    end
  end
end
