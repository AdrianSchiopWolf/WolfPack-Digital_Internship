# frozen_string_literal: true

class UserSerializer < ApplicationSerializer
  attributes :id, :email, :username
  attributes :tokens, if: proc { @with_auth_tokens }

  def initialize(user, params: {}, with_auth_tokens: false)
    super(user, params: params)
    @with_auth_tokens = with_auth_tokens
  end

  attribute :message, if: proc { params[:with_message].present? } do
    params[:with_message]
  end
end
