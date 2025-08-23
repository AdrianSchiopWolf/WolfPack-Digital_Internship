# frozen_string_literal: true

class UsersController < Devise::RegistrationsController
  layout 'authenticated'
end
