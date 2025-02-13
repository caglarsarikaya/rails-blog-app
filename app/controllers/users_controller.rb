class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user

  def show
    @posts = @user.posts.order(created_at: :desc)
  end

  def settings
    # This action is for account settings
  end

  def update_settings
    if @user.update(user_params)
      bypass_sign_in(@user) if user_params[:password].present?
      redirect_to settings_user_path(@user), notice: 'Your settings have been updated successfully.'
    else
      render :settings, status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :bio)
  end
end
