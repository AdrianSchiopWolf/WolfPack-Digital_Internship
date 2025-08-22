# frozen_string_literal: true

module Api
  module V1
    module SessionsControllerDoc
      extend ActiveSupport::Concern

      included do
        extend Apipie::DSL::Concern

        resource_description do
          short 'User authentication (login & logout)'
          description 'Handles login with email/password and logout (token revocation).'
        end

        api :POST, '/v1/sessions', 'Log in a user'
        param :session, Hash, desc: 'User login credentials', required: true do
          param :email, String, desc: 'User email', required: true
          param :password, String, desc: 'User password', required: true
        end
        returns code: 200, desc: 'Successful login'
        def create; end

        api :DELETE, '/v1/sessions', 'Log out a user'
        header 'Authorization', 'Bearer access_token', required: true
        returns code: 200, desc: 'Successfully logged out'
        def destroy; end
      end
    end
  end
end
