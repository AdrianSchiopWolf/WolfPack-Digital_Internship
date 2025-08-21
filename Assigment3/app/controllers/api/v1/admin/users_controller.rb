module Api
  module V1
    module Admin
      class UsersController < Api::V1::Admin::BaseController
        def index
          users = User.all
          render json: Alba.serialize(users, with: UserSerializer)
        end
      end
    end
  end
end

  