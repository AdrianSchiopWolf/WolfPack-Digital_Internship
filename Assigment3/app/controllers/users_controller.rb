class UsersController < ApplicationController
  layout 'authenticated'
  skip_before_action :require_login!, only: [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to login_path, notice: 'User created successfully.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end
end
