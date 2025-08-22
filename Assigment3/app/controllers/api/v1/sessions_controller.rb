# frozen_string_literal: true

module Api
  module V1
    class SessionsController < BaseController
      skip_before_action :doorkeeper_authorize!, only: :create

      def create
        user = User.authenticate(user_sign_in_params[:email], user_sign_in_params[:password])

        return render_error_message(I18n.t('devise.failure.invalid', authentication_keys: :email)) unless user

        if user.active_for_authentication?
          render json: UserSerializer.new(user, with_auth_tokens: true).serialize, status: :ok
        else
          render_error_message(I18n.t('devise.failure.unconfirmed'))
        end
      end

      def destroy
        if doorkeeper_token
          doorkeeper_token.revoke
          render json: { message: 'Logged out successfully' }, status: :ok
        else
          render json: { error: 'Invalid or missing token' }, status: :unauthorized
        end
      end

      private

      def user_sign_in_params
        params.fetch(:session, {}).permit(:email, :password)
      end
    end
  end
end
