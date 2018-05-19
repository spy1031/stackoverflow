class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:edit, :show, :update]
  
  def edit
  end
  
  def update
    @user.update(user_params)
    redirect_to user_path(@user)
  end
  
  def show
  end
  
  def favorite
  end
  
  private
  def set_user
    @user = User.find(params[:id])
  end
  
  def user_params
    params.require(:user).permit(
      :name,
      :introduction,
      :company,
      :job_title,
      :website,
      :twitter,
      :github,
      :avatar)

  end
end
