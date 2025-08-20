# frozen_string_literal: true

class ApplicationSerializer
  include Alba::Resource

  def current_user
    params.fetch(:current_user, nil)
  end
end
