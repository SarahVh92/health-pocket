class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    authorize @user
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to root_path
      authorize @user
    else
      render :show
    end
  end

  private

  def user_params
    params.require(:user).permit(:allergies)
  end
end
