# frozen_string_literal: true

class SessionsController < Devise::SessionsController
  layout 'authenticated'
  skip_before_action :authenticate_user!, only: %i[new create]
end
