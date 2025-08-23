# frozen_string_literal: true

module Api
  module V1
    module Admin
      class UsersController < Api::V1::Admin::BaseController
        # include Api::V1::Admin::UsersControllerDoc

        def index
          users = User.all
          render json: Alba.serialize(users, with: UserSerializer)
        end
      end
    end
  end
end
