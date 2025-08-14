# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
    @user = User.new(username: 'testuser', email: 'testuser@example.com', password: 'Password1!')
  end
end
