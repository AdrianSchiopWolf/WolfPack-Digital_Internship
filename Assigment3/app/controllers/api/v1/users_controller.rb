# frozen_string_literal: true

module Api
  module V1
    class UsersController < BaseController
      skip_before_action :doorkeeper_authorize!, only: [:create]

      def create
        user = User.new(user_params)

        if user.save
          render json: UserSerializer.new(user, with_auth_tokens: false).as_json, status: :created
        else
          render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def destroy
        user = current_user
        return render_error_message('Not authorized') unless user

        user.destroy
        head :no_content
      end

      private

      def user_params
        params.permit(:username, :email, :password, :password_confirmation)
      end
    end
  end
end
