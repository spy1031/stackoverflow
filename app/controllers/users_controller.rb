class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:edit, :show, :update, :favorite]
  
  def edit
  end
  
  def update
    @user.update(user_params)
    redirect_to user_path(@user)
  end
  
  def show
  end
  
  def favorite
    if @user != current_user
      flash[:alert] = "你不能觀看其他使用者的收藏"
      redirect_to root_path
    else
      @favorited_questions = @user.favorited_questions
    end
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
