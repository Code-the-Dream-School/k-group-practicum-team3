class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: %i[show edit update]

  def show; end

  def edit
    authorize @user
  end

  def update
    authorize @user

    if @user.update(user_params)
      redirect_to @user, notice: "Profile updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name)
  end
end
