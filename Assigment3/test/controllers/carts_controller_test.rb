# frozen_string_literal: true

require 'test_helper'

class CartsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:user_one)
    @product = products(:product_two)
  end

  test 'authenticated user can add product to cart' do
    post login_path, params: { email: @user.email, password: 'password' }

    assert_difference -> { @user.cart_items.count }, 1 do
      post carts_path, params: { product_id: @product.id }
      @user.reload
    end

    assert_redirected_to root_path
  end

  test 'unauthenticated user cannot add product to cart' do
    assert_no_difference 'Cart.count' do
      post carts_path, params: { product_id: @product.id }
    end

    assert_redirected_to login_path
  end
end
