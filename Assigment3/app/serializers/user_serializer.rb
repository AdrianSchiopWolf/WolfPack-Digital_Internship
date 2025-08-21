# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  username               :string           not null
#  email                  :string           not null
#  role                   :integer          default("user"), not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#
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
