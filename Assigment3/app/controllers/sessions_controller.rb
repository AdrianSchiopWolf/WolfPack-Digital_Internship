# frozen_string_literal: true

class SessionsController < ApplicationController
  layout 'authenticated'
  skip_before_action :require_login!, only: %i[new create]

  def new; end

  def create
    user = User.find_by(email: params[:email])
    Rails.logger.info "Attempting to log in user: #{params[:email]}"
    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_path, notice: 'Logged in successfully.'
    else
      flash.now[:alert] = 'Invalid email or password.'
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: 'Logged out successfully.'
  end
end
