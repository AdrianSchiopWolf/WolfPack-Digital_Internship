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
class User < ApplicationRecord
  class << self
    def authenticate(email, password)
      user = find_for_authentication(email: email)
      user&.valid_password?(password) ? user : nil
    end
  end

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :username, presence: true, uniqueness: true
  validate :password_complexity
  has_many :cart_items, dependent: :destroy
  has_many :products, dependent: :destroy, through: :cart_items
  has_many :orders, dependent: :destroy
  has_many :access_tokens, class_name: 'Doorkeeper::AccessToken', foreign_key: :resource_owner_id, dependent: :delete_all

  enum role: { user: 0, admin: 1 }

  def tokens
    app = Doorkeeper::Application.first

    token = access_tokens
            .where('revoked_at IS NULL AND expires_in + created_at > ?', Time.current)
            .first
    token ||= access_tokens.create!(
      resource_owner_id: id,
      application_id: app.id,
      use_refresh_token: Doorkeeper.configuration.refresh_token_enabled?,
      expires_in: Doorkeeper.configuration.access_token_expires_in
    )

    Doorkeeper::OAuth::TokenResponse.new(token).body.with_indifferent_access
  end

  private

  def password_complexity
    return if password.blank? || password.match(/\A(?=.*[a-z])(?=.*[A-Z])(?=.*\d).{6,}\z/)

    errors.add :password, 'must include at least one lowercase letter, one uppercase letter, and one digit'
  end
end
