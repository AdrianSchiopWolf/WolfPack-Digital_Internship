# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :require_login!
  helper_method :current_user, :logged_in?

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    current_user.present?
  end

  def require_login!
    return if logged_in?

    redirect_to login_path, alert: 'You must be logged in to access this section.'
  end
end
