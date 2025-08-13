class Admin::BaseController < ApplicationController
  before_action :require_admin!

  private

  def require_admin!
    redirect_to root_path, alert: 'You must be an admin to access this section.' unless current_user&.admin?
  end
end
