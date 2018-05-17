class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: [:index]

  def index
    @questions = Question.all.page(params[:page]).per(10)
  end

  def new
    @question = Question.new
  end
end
