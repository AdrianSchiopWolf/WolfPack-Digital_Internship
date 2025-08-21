module Api
  module V1
    module Admin
      class BaseController < Api::V1::BaseController
        before_action :authenticate_user!

        private

        def authenticate_user!
          render json: { error: 'Unauthorized' }, status: :unauthorized unless current_user&.admin?
        end
      end
    end
  end
end