class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: [:index]

  def index
    @questions = Questions.all.page(params[:page]).per(10)
  end
end
