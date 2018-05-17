class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: [:index]

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

  private

  def question_params
    params.require(:question).permit(
      :title,
      :content)
  end
end
