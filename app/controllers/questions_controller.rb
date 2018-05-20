class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  before_action :set_question, only: [:show, :favorite, :unfavorite, :upvote, :unupvote]

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
    @solution_by_upvote = @question.solutions.order(upvotes_count: :desc)
    @solution = Solution.new
  end
  
  def favorite
    favorites = Favorite.where(question: @question, user: current_user)
    if favorites.exists?
      flash[:alert] = "已被收藏"
    else
      @question.favorites.create!(user: current_user)
    end
  end

  def unfavorite
    favorites = Favorite.where(question: @question, user: current_user)
    favorites.destroy_all
  end
  
  def upvote
    upvotes = Upvote.where(question: @question, user: current_user)
    if upvotes.exists?
      flash[:alert] = "已按過"
    else
      @question.upvotes.create!(user: current_user)
    end
  end

  def unupvote
    upvotes = Upvote.where(question: @question, user: current_user)
    upvotes.destroy_all
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
