class QuestionsController < ApplicationController
  def index
    @questions = Questions.all.page(params[:page]).per(10)
  end
end
