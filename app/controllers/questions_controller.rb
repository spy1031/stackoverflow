class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  before_action :set_question, only: [:show, :favorite, :unfavorite]

  def index
    @questions = Question.all.page(params[:page]).per(10)
  end

  def new
    @question = Question.new
  end

  def create
    @question = current_user.questions.new(question_params)
    if @question.save
      flash[:notice] = "問題發布成功"
      redirect_to question_path(@question)
    else
      flash.now[:alert] = "問題發布失敗"
      render :new
    end
  end

  def show
  end
  
  def favorite
    favorites = Favorite.where(question: @question, user: current_user)
    if favorites.exists?
      flash[:alert] = "已被收藏"
    else
      @question.favorites.create!(user: current_user)
    end
    render :json => {:favorites_count => @question.favorites_count}
  end

  def unfavorite
    favorites = Favorite.where(question: @question, user: current_user)
    favorites.destroy_all
  end
  
  private

  def question_params
    params.require(:question).permit(
      :title,
      :content)
  end

  def set_question
    @question = Question.find(params[:id])
  end
end
